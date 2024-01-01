import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gurukul_mobile_app/Components/customAppBar.dart';
import 'package:gurukul_mobile_app/Controllers/AdminController/aNoticeContoller.dart';
import 'package:gurukul_mobile_app/Models/AdminModels/aNoticeModel.dart';
import 'package:gurukul_mobile_app/Views/AdminView/aAddNotice.dart';

class AdminViewNotice extends StatefulWidget{
  final String classId;

  AdminViewNotice({required this.classId});
  @override
  State<AdminViewNotice> createState() => _AdminViewNoticePageState();
}

class _AdminViewNoticePageState extends State<AdminViewNotice>{
  final NoticeController _noticeController = NoticeController();
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  late String classId;

  void initState(){
    super.initState();
    classId = widget.classId;
  }

  Future<void> refresh()async{
    setState(() {

    });
  }



  late List<File> _files = [];
  Image? previewImage;

  void _editNotice(String title, String description, String fileUrl, String subDocumentId){
    final TextEditingController noticeTitle = TextEditingController(text: title);
    final TextEditingController noticeDescription = TextEditingController(text: description);

    Future<void> getFiles() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
      if(result != null){
        _files = result.files.map((file) => File(file.path!)).toList();
        setState(() {
        });
      }
    }

    void refreshBottomSheet() {
      Navigator.pop(context); // Close the current bottom sheet
      _editNotice(title, description, fileUrl, subDocumentId); // Open a new bottom sheet
    }

    String _getContentType(String filePath){
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

    Future<void> uploadDateFiles() async {
      if (_files == null || _files.isEmpty) {
        print("No files displayed");
        return;
      }

      String downloadURLs = "";

      try {
        for (File file in _files) {
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          Reference ref = firebaseStorage.ref().child('files/$fileName');
          String contentType = _getContentType(file.path);
          SettableMetadata metadata = SettableMetadata(contentType: contentType);
          UploadTask uploadTask = ref.putFile(file, metadata);

          // Wait for the upload task to complete
          TaskSnapshot taskSnapshot = await uploadTask;

          // Get the download URL after the upload is complete
          String fileDownloadURL = await taskSnapshot.ref.getDownloadURL();
          downloadURLs = fileDownloadURL;
        }

        if(classId.isNotEmpty && subDocumentId.isNotEmpty){
          NoticeModel noticeModel = NoticeModel(
              title: noticeTitle.text,
              description: noticeDescription.text,
              documentUrl: downloadURLs
          );
          _noticeController.updateNotice(classId, subDocumentId, noticeModel);
          Navigator.pop(context);
        }else{
          print('No documentId to update class Id: $classId document Id: $subDocumentId');
        }

        // Print the download URLs for debugging
        print("Download URLs: $fileUrl");
      } catch (e) {
        print('Error uploading files: $e');
        // Handle errors if needed
      }
    }

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        builder: (BuildContext context){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: ()async{
                          await getFiles();
                          setState(() {
                            // Now update the previewImage after the file is picked
                            previewImage = _files.isNotEmpty
                                ? Image.file(
                              _files.first,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            )
                                : null;
                          });
                          refreshBottomSheet();
                        },
                        child: Container(
                            width: 250,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Color(0xFFF2F2F2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.upload_file, color: Colors.black),
                                Text('Upload Files/Image'),
                              ],
                            )
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
                            child: previewImage ?? Image.network(fileUrl)

                        ),
                      ),

                    ],
                  ),
                  const SizedBox(height: 20),
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
                  Column(
                    children: [
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: ElevatedButton(
                                  onPressed: (){
                                    Navigator.pop(context);
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
                                    uploadDateFiles();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue, // Background color
                                    onPrimary: Colors.white, // Text color
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Padding
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10), // Border radius
                                    ),
                                  ),
                                  child: Text('Edit')
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )

                ],
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(title: 'View Notices'),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminNoticePage(classId: classId),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: 130,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Colors.white,),
                        Text('Create Notice', style: TextStyle(color: Colors.white),),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text('View Notices', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500 ),),
              ],
            ),
          ),
          Expanded(
              child: RefreshIndicator(
                onRefresh: refresh,
                child: StreamBuilder<List<NoticeModel>>(
                    stream: _noticeController.getNotice(classId),
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator());
                      }

                      if(snapshot.hasError){
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      List<NoticeModel> notices = snapshot.data ?? [];

                      if(notices.isEmpty){
                        return Center(child: Text('No notices available.'));
                      }

                      return ListView.builder(
                          itemCount: notices.length,
                          itemBuilder: (context, index){
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: InkWell(
                                onTap: ()async{
                                  CollectionReference collection = FirebaseFirestore.instance.collection('classes').doc(classId).collection('notices');
                                  QuerySnapshot querySnapshot = await collection.get();
                                  DocumentSnapshot documentSnapshot = querySnapshot.docs[index];

                                  String documentId = documentSnapshot.id;
                                  _editNotice(
                                      notices[index].title,
                                      notices[index].description,
                                    notices[index].documentUrl,
                                      documentId
                                  );
                                },
                                child: Card(
                                  child: ListTile(
                                    title: Text(notices[index].title),
                                    subtitle: Text(notices[index].description),
                                    trailing: IconButton(
                                        onPressed: ()async{
                                          CollectionReference collection = FirebaseFirestore.instance.collection('classes').doc(classId).collection('notices');
                                          QuerySnapshot querySnapshot = await collection.get();
                                          DocumentSnapshot documentSnapshot = querySnapshot.docs[index];

                                          String documentId = documentSnapshot.id;
                                          _noticeController.deleteNotice(classId, documentId);
                                          refresh();
                                        },
                                        icon: Icon(Icons.delete)
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                      );
                    }
                ),
              )
          )
        ],
      ),
    );
  }

}