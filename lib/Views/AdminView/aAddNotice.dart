import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gurukul_mobile_app/Components/customAppBar.dart';
import 'package:gurukul_mobile_app/Controllers/AdminController/aNoticeContoller.dart';
import 'package:gurukul_mobile_app/Models/AdminModels/aNoticeModel.dart';

class AdminNoticePage extends StatefulWidget {
  // variable
  final String classId;

  AdminNoticePage({required this.classId});

  @override
  State<AdminNoticePage> createState() => _AdminNoticePageState();
}

class _AdminNoticePageState extends State<AdminNoticePage> {
  // variable declaration
  final TextEditingController noticeTitle = TextEditingController();
  final TextEditingController noticeDescription = TextEditingController();
  final NoticeController noticeController = NoticeController();
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  late String classId;

  // init method
  void initState(){
    super.initState();
    classId = widget.classId;
  }

  Image? previewImage;
  List<File> _files = [];

  Future<void> getFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if(result != null){
      _files = result.files.map((file) => File(file.path!)).toList();
      setState(() {
        previewImage = Image.file(
          _files.first,
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        );
      });
    }
}

Future<void> uploadDataFile() async {
    // condition check
    if(_files == null && _files.isEmpty){
      print("No files to display");
    }

      String downloadedUrl = "";

    // try-catch block for error handling
    try {
      for(File file in _files){
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference reference = firebaseStorage.ref().child('files/$fileName');
        String contentType = _getContentType(file.path);
        SettableMetadata metadata = SettableMetadata(contentType: contentType);
        UploadTask uploadTask = reference.putFile(file, metadata);

        TaskSnapshot taskSnapshot = await uploadTask;

        String filePath = await taskSnapshot.ref.getDownloadURL();
        downloadedUrl = filePath;
      }
      print("Download URLs: $downloadedUrl");

      NoticeModel noticeModel = NoticeModel(
        title: noticeTitle.text,
        description: noticeDescription.text,
        documentUrl: downloadedUrl,
          currentDate: DateTime.now()
      );

      noticeController.addNotice(classId, noticeModel);
      noticeTitle.clear();
      noticeDescription.clear();
      Navigator.pop(context);
    }
    catch(e) {
      print('error uplading file and data $e');
    }
}

  String _getContentType(String filePath) {
    Map<String, String> contentTypeMap = {
      'pdf': 'application/pdf',
      'doc' : 'application/msword',
      'docx' : 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      'jpeg': 'image/jpeg',
      'jpg': 'image/jpeg',
      'png': 'image/png',
    };
    String extension = filePath.split('.').last.toLowerCase();

    return contentTypeMap[extension] ?? 'application/octet-stream';
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(title: 'Add Notice'),
      body: Padding(
        padding: const EdgeInsets.only(top: 25.0, right: 14.0, left: 14.0),
        child: Column(
          children: [
            const Row(
              children: [
                Text('Notice Title', style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500),),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: TextField(
                controller: noticeTitle,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF808080))
                  ),
                  hintText: 'Enter Title',
                  hintStyle: TextStyle(color: Color(0xFF808080))
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            const Row(
              children: [
                Text('Notice Description', style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500),),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: TextField(
                controller: noticeDescription,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF808080))
                    ),
                    hintText: 'Enter Description',
                    hintStyle: TextStyle(color: Color(0xFF808080))
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                GestureDetector(
                  onTap: (){
                    getFiles();
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 250,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                          child: const Padding(
                            padding: EdgeInsets.only(top: 16.0),
                            child: Column(
                              children: [
                                  Icon(Icons.upload_file, color: Colors.black),
                                Text('Upload Files/Image'),
                              ],
                            ),
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Container(
                          height: 80,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Color(0xFFF2F2F2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: previewImage,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ElevatedButton(
                            onPressed: (){Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white, // Background color
                              onPrimary: Colors.black, // Text color
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Padding
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Colors.black, width: 1),// Border radius
                              ),
                            ),
                            child: Text('Cancel')
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: ElevatedButton(
                            onPressed: (){
                              uploadDataFile();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue, // Background color
                              onPrimary: Colors.white, // Text color
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Padding
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), // Border radius
                              ),
                            ),
                            child: Text('Create')
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}