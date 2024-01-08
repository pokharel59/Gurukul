import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gurukul_mobile_app/Components/messageToast.dart';
import 'package:gurukul_mobile_app/Components/studentCustomAppBar.dart';
import 'package:gurukul_mobile_app/Controllers/AdminController/aAssignmentController.dart';
import 'package:gurukul_mobile_app/Controllers/StudentController/submitAssignment.dart';
import 'package:gurukul_mobile_app/Models/AdminModels/aAssignmentModel.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:transparent_image/transparent_image.dart';

class AssignmentPage extends StatefulWidget {
  final String classId;
  final String studentName;
  final String studentID;

  AssignmentPage({required this.classId, required this.studentName, required this.studentID});

  @override
  State<AssignmentPage> createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  final AssignmentController assignmentController = AssignmentController();
  final SubmitAssignmentController submitAssignmentController = SubmitAssignmentController();
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final Toaster showMessage = Toaster();

  //bool isAssignmentSubmitted = false;

  var orange_color = Color(0xfff04d22);
  var primary_color = Color(0xFF687EFF);
  var grey_color = Colors.grey;
  late String classId;
  late String studentName;
  late String studentID;
  late List<File> _files = [];
  Image? previewImage;

  void initState(){
    super.initState();
    classId = widget.classId;
    studentName = widget.studentName;
    studentID = widget.studentID;
  }

  Future<void> refresh() async {
    setState(() {});
  }

  Future<void> getFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

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

  Future<void> uploadDateFiles(String assignmentId, String assignmentText, DateTime deadline)async{
    // if (_files == null || _files.isEmpty) {
    //   print("No files displayed");
    //   return;
    // }

    String ? downloadURLs = "";

    try{
      for (File file in _files){
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

        Map<String, dynamic> newSubmittion = {
          'id': studentID,
          'name': studentName,
          'documentUrl': downloadURLs,
          'assignmentText': assignmentText ?? []
        };
        print("$newSubmittion");
        print("class Id: $classId");
        print("assignmentId: $assignmentId");
        try{
            await submitAssignmentController.submitAssignment(classId, assignmentId, newSubmittion);
            showMessage.showToast('Assignment submitted');
        }catch(e){
          showMessage.showToast('Error submitting assignment');
        }
      }
    }catch(e){
      print(" error: $e");
    }
  }

  void submitAssignment(String subject, String title, DateTime deadline, String description, String fileURL, String assignmentId, bool isTodayDeadline, bool isAssignmentSubmitted, List<Map<String, dynamic>> submittedAssignment){
   final TextEditingController assignmentText = TextEditingController();

    void refreshBottomSheet(){
      Navigator.pop(context);
      submitAssignment(subject, title, deadline, description, fileURL, assignmentId, isTodayDeadline, isAssignmentSubmitted, submittedAssignment);
    }

    showBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20)
          )
        ),
        builder: (BuildContext context){
          return Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8, right: 15, left: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Text(subject, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),)),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title),
                      Text(deadline.toString())
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(description),
                  SizedBox(height: 15),
                  Container(
                    height: 150,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                    ),
                      child: Image.network(fileURL)
                  ),
                  SizedBox(height: 30),
                  Text('Your Submission: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: 100,
                            width: 250,
                            child: TextField(
                              controller: assignmentText,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF808080)),
                                ),
                                hintText: 'Type Your Answer',
                                hintStyle: TextStyle(color: Color(0xFF808080)),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 8,
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: previewImage,
                              ),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: ()async{
                          await getFiles();
                          refreshBottomSheet();
                        },
                        child: Container(
                            height: 50,
                            width: 50,
                            color: Colors.blue,
                            child: Icon(Icons.file_copy_rounded, color: Colors.white,),
                          ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    child: Expanded(
                      child: SizedBox(
                        width: double.maxFinite,
                        child: isAssignmentSubmitted
                            ? ListView.builder(
                          itemCount: submittedAssignment.length,
                          itemBuilder: (context, index) {
                            var submission = submittedAssignment[index];
                            return Card(
                              child: ListTile(
                                leading: Image.network(
                                  submission['documentUrl'],
                                  width: 50,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(submission['assignmentText']),
                                trailing: IconButton(
                                  onPressed: (){
                                    Map<String, dynamic> fromStudent = {
                                      'id': studentID,
                                      'name': studentName,
                                    };
                                    submitAssignmentController.deleteSubmitted(classId, assignmentId, fromStudent);
                                  },
                                  icon: Icon(Icons.delete),
                                )
                              ),
                            );
                          },
                        )
                            : ElevatedButton(
                          onPressed: isTodayDeadline
                              ? () => uploadDateFiles(
                            assignmentId,
                            assignmentText.text,
                            deadline,
                          )
                              : null,
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: StudentCustomAppBar(title: 'Assignment', studentName: studentName, studentId: studentID,),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        height: size.height,
        width: size.width,
        color: Colors.white,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
          Text('Assignments', style: TextStyle(color: primary_color, fontSize: 24, fontWeight: FontWeight.w500,)),
        SizedBox(height: 8),
            Expanded(
                 child: RefreshIndicator(
                   onRefresh: refresh,
                   child: StreamBuilder<List<AssignmentModel>>(
                     stream: assignmentController.getAssignment(classId),
                     builder: (context, snapshot){
                       if(snapshot.connectionState == ConnectionState.waiting){
                         return Center(child: LoadingAnimationWidget.inkDrop(color:primary_color, size: 37));
                       }

                       if(snapshot.hasError){
                         return Center(child: Text('Error: ${snapshot.error}'));
                       }

                       List<AssignmentModel> assignments = snapshot.data ?? [];
                       print(assignments);


                       if(assignments.isEmpty){
                         return Center(child: Text('No assignments available.'));
                       }

                       return ListView.builder(
                         itemCount: assignments.length,
                           itemBuilder: (context, index){
                           String assignmentSubject = assignments[index].subject;
                           DateTime assignmentDate = assignments[index].deadline;

                           bool isTodayDeadline = assignmentDate.isAfter(DateTime.now());

                           List<Map<String, dynamic>> checkAssignmentSubmitted = assignments[index].studentsSubmittion;
                           bool isAssignmentSubmitted = checkAssignmentSubmitted.any(
                                   (assignmentSubmit) =>
                               assignmentSubmit.containsValue(studentName) &&
                                   assignmentSubmit.containsValue(studentID) );

                           // while (isCheckedList.length <= index) {
                           //   isCheckedList.add(false);
                           // }
                           return InkWell(
                               onTap: ()async{
                                 CollectionReference collection = FirebaseFirestore.instance.collection('classes').doc(classId).collection('assignments');
                                 QuerySnapshot querySnapshot = await collection.get();
                                 DocumentSnapshot documentSnapshot = querySnapshot.docs[index];

                                 String documentId = documentSnapshot.id;
                                 submitAssignment(
                                   assignments[index].subject,
                                   assignments[index].title,
                                   assignments[index].deadline,
                                   assignments[index].description,
                                   assignments[index].documentUrl,
                                     documentId,
                                     isTodayDeadline,
                                   isAssignmentSubmitted,
                                     assignments[index].studentsSubmittion
                                 );
                               },
                               child: Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Container(
                                   height: 60,
                                   width: size.width,
                                   decoration: BoxDecoration(
                                     color: Color(0xfffad8d6),
                                     borderRadius: BorderRadius.circular(10),
                                   ),
                                   child: Row(
                                     children: [
                                       IconButton(
                                         onPressed: () {

                                         },
                                         icon: isAssignmentSubmitted
                                             ? Icon(Icons.check_circle_rounded, color: primary_color,)
                                             : Icon(Icons.circle_outlined, color: Colors.grey.shade600,),
                                       ),
                                       Padding(
                                         padding: EdgeInsets.only(top: 8),
                                         child: Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Text(assignments[index].title),
                                             SizedBox(height: 6),
                                             Text( '$assignmentSubject / $assignmentDate' ,style: TextStyle(fontSize: 12,color: Colors.grey.shade600)),
                                           ],
                                         ),
                                       ),
                                     ],
                                   ),
                                 ),
                               ),
                             );
                           }

                       );
                     },
                   ),
                 ),
            ),

          ],
        ),
      ),
    );
  }
}


//async