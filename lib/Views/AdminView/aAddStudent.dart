import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gurukul_mobile_app/Controllers/AdminController/aStudentController.dart';
import 'package:gurukul_mobile_app/Models/AdminModels/aStudentModel.dart';
import 'package:gurukul_mobile_app/Views/AdminView/aAddTeacher.dart';

import '../../Components/customAppBar.dart';

class AdminStudent extends StatefulWidget{
  final String classId;

  // Receive classId as a parameter in the constructor
  AdminStudent({required this.classId});
  @override
  State<AdminStudent> createState() => _AdminStudentPageState();
}
class _AdminStudentPageState extends State<AdminStudent>{
  final TextEditingController _studentName = TextEditingController();
  final TextEditingController _studentID = TextEditingController();
  final TextEditingController _studentPassword = TextEditingController();
  final StudentController studentController = StudentController();

  late String classId;

  @override
  void initState() {
    super.initState();
    // Initialize classId in the initState method
    classId = widget.classId;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: CustomAppBar(title: 'Add Student'),
        body: Padding(
          padding: EdgeInsets.only(right: 5.0, left: 15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      width: 170,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          children: [
                            Icon(Icons.people, size: 30,),
                            Text('Student')
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminTeacher(classId: classId),
                            )
                        );
                      },
                      child: Container(
                        height: 100,
                        width: 170,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            children: [
                              Icon(Icons.people_alt_outlined, size: 30,),
                              Text('Teacher')
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text('Student Management', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500 ),),
                    ),
                  ]),
              SizedBox(height: 6),
              Row(
                children: [
                  Text('Create Student', style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w400 ),),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text('Student Name', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500 ),),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 50,
                child: TextField(
                  controller: _studentName,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF808080))
                      ),
                      hintText: 'Enter Student Name',
                      hintStyle: TextStyle(color: Color(0xFF808080))
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text('Student ID', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500 ),),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 50,
                child: TextField(
                  controller: _studentID,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF808080))
                      ),
                      hintText: 'Enter Student ID',
                      hintStyle: TextStyle(color: Color(0xFF808080))
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('Student Password', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500 ),),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 50,
                child: TextField(
                  controller: _studentPassword,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF808080))
                      ),
                      hintText: 'Enter Student Password',
                      hintStyle: TextStyle(color: Color(0xFF808080))
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 50,
                child: Row(
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
                              StudentModel studentModel = StudentModel(
                                  name: _studentName.text,
                                  id: _studentID.text,
                                  password: _studentPassword.text
                              );

                              studentController.addStudent(classId, studentModel);
                              _studentID.clear();
                              _studentName.clear();
                              _studentPassword.clear();
                              Navigator.pop(context);
                              print('class id: $classId');
                              //Navigator.pushReplacementNamed(context, '/createTeacher');
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
                    ),
                  ],
                ),
              ),

            ],
          ),
        )
    );
  }

}
