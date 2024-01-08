import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gurukul_mobile_app/Components/studentCustomAppBar.dart';
import 'package:gurukul_mobile_app/Controllers/AdminController/aAssignmentController.dart';
import 'package:gurukul_mobile_app/Controllers/StudentController/submitAssignment.dart';
import 'package:gurukul_mobile_app/Models/AdminModels/aAssignmentModel.dart';

class AssignmentPage extends StatefulWidget {
  final String classId;
  final String studentName;
  final String studentID;

  AssignmentPage({required this.classId, required this.studentName, required this.studentID});

  @override
  State<AssignmentPage> createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  // variable declarations
  final AssignmentController assignmentController = AssignmentController();
  final SubmitAssignmentController submitAssignmentController = SubmitAssignmentController();
  var orange_color = Color(0xfff04d22);
  var primary_color = Color(0xffbe00fe);
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

  void submitAssignment(String subject, String title, String date, String description, String fileURL, String assignmentId){

    void refreshBottomSheet(){
      Navigator.pop(context);
      submitAssignment(subject, title, date, description, fileURL, assignmentId);
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
                      Text(date)
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
                  SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                        onPressed: ()async{
                          Map<String, dynamic> newSubmittion = {
                            'id': studentID,
                            'name': studentName,
                          };
                          print("$newSubmittion");
                          print("class Id: $classId");
                          print("assignmentId: $assignmentId");
                          await submitAssignmentController.submitAssignment(classId, assignmentId, newSubmittion);
                        },
                        child: Text('Submit', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
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
      appBar: StudentCustomAppBar(title: 'Assignment'),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        height: size.height,
        width: size.width,
        color: Colors.white,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            Text('Today', style: TextStyle(color: primary_color, fontSize: 24, fontWeight: FontWeight.w500,)),
            //main contents
            SizedBox(height: 8),
            Expanded(
                 child: StreamBuilder<List<AssignmentModel>>(
                   stream: assignmentController.getAssignment(classId),
                   builder: (context, snapshot){
                     if(snapshot.connectionState == ConnectionState.waiting){
                       return Center(child: CircularProgressIndicator());
                     }

                     if(snapshot.hasError){
                       return Center(child: Text('Error: ${snapshot.error}'));
                     }

                     List<AssignmentModel> assignments = snapshot.data ?? [];

                     if(assignments.isEmpty){
                       return Center(child: Text('No assignments available.'));
                     }

                     return ListView.builder(
                       itemCount: assignments.length,
                         itemBuilder: (context, index){
                         String assignmentSubject = assignments[index].subject;
                         String assignmentDate = assignments[index].deadline;
                         return InkWell(
                             onTap: (){
                               submitAssignment(
                                 assignments[index].subject,
                                 assignments[index].title,
                                 assignments[index].deadline,
                                 assignments[index].description,
                                 assignments[index].documentUrl,
                                   'QBZDQW1ROQ75mCUmH5gh'
                               );
                             },
                             child: Container(
                               height: 60,
                               width: size.width,
                               decoration: BoxDecoration(
                                 color: Color(0xfffad8d6),
                                 borderRadius: BorderRadius.circular(10),
                               ),
                               child: Row(
                                 children: [
                                   IconButton(onPressed: (){}, icon: Icon(Icons.check_circle_rounded, color: primary_color,)),
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
                           );
                         }

                     );
                   },
                 ),
            ),

          ],
        ),
      ),
    );
  }
}
