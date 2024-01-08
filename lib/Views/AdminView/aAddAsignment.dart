import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gurukul_mobile_app/Components/customAppBar.dart';
import 'package:gurukul_mobile_app/Controllers/AdminController/aAssignmentController.dart';
import 'package:gurukul_mobile_app/Models/AdminModels/aAssignmentModel.dart';
import 'package:intl/intl.dart';

class AdminAssignmentPage extends StatefulWidget{
  final String classID;

  AdminAssignmentPage({required this.classID});

  @override
  State<AdminAssignmentPage> createState() => _AdminAssignmentPageState();
}

class _AdminAssignmentPageState extends State<AdminAssignmentPage> {
  // variables declaration
  late String classId;
  final TextEditingController assignmentTitle = TextEditingController();
  final TextEditingController assignmentDescription = TextEditingController();
  final AssignmentController assignmentController = AssignmentController();
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  late List<File> _files = [];

  // init method
  void initState(){
    super.initState();
    classId = widget.classID;
  }

  // values assigned to variables
  String selectedItem = 'science';
  List<String> subjectItemList = ['math', 'science', 'nepali'];
  DateTime selectDateTime = DateTime.now();

  Future<void> _selectDatetime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    // condition check
    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectDateTime),
      );

      if (pickedTime != null) {
        DateTime pickedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          selectDateTime = pickedDateTime;
        });
      }
    }
  }

  Image? previewImage;

  Future<void> getFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

    // condition check
    if (result != null) {
      _files = result.files.map((file) => File(file.path!)).toList();
      setState(() {
        previewImage = Image.file(
            _files.first,
            width: 100,
            height: 100,
            fit: BoxFit.cover
        );
      });
    }
  }

  Future<void> uploadDateFiles() async {
    if (_files == null || _files.isEmpty) {
      print("No files displayed");
      return;
    }

    String downloadURLs = "";

    // try-catch block (error handling)
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

      // Print the download URLs for debugging
      print("Download URLs: $downloadURLs");

      // Once all files are uploaded, proceed with Firestore operation
      //String formattedDeadline = DateFormat('yyyy-MM-dd HH:mm:ss Z').format(selectDateTime);
      AssignmentModel assignmentModel = AssignmentModel(
        title: assignmentTitle.text,
        description: assignmentDescription.text,
        subject: selectedItem,
        deadline: selectDateTime,
        documentUrl: downloadURLs,
        studentsSubmittion: [],
        date: DateTime.now()
      );

      // Print the AssignmentModel for debugging
      print("AssignmentModel: $assignmentModel");

      assignmentController.addAssignment(classId, assignmentModel);
      assignmentTitle.clear();
      assignmentDescription.clear();
      Navigator.pop(context);
    }
    catch (e) {
      // Handle errors if needed
      print('Error uploading files: $e');
    }
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: CustomAppBar(title: 'Add Assignment'),
        body: Padding(
          padding: const EdgeInsets.only(top: 25.0, right: 14.0, left: 14.0),
          child: Column(
            children: [
              const Row(
                children: [
                  Text('Assignment Title', style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500),),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                child: TextField(
                  controller: assignmentTitle,
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
                  Text('Assignment Description', style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500),),
                ],
              ),
              const SizedBox(height: 10),
               SizedBox(
                height: 50,
                child: TextField(
                  controller: assignmentDescription,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF808080))
                      ),
                      hintText: 'Enter Description',
                      hintStyle: TextStyle(color: Color(0xFF808080))
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Column(
                    children: [
                      const Text('Select Subject', style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500),),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
                        child: DropdownButton<String>(
                          value: selectedItem,
                          onChanged: (String? newItem){
                            setState(() {
                              selectedItem = newItem ?? '';
                            });
                          },
                          items: subjectItemList.map((String item){
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Assignment Deadline', style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500),),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                        onPressed: (){
                          _selectDatetime(context);
                        },
                          child: Row(
                            children: [
                              Icon(Icons.calendar_month),
                              Text('Choose Date'),
                            ],
                          ),
                    ),
                  ),
                  Text('$selectDateTime'),
                ],
              ),
              SizedBox(height: 20),
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
                              onPressed: (){

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
                              onPressed: () {
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