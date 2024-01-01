import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gurukul_mobile_app/Components/adminButtonNav.dart';
import 'package:gurukul_mobile_app/Components/customAppBar.dart';
import 'package:gurukul_mobile_app/Controllers/AdminController/aClassController.dart';
import 'package:gurukul_mobile_app/Controllers/AdminController/aTeacherController.dart';
import 'package:gurukul_mobile_app/Views/AdminView/aAddStudent.dart';

import '../../Controllers/AdminController/aStudentController.dart';
import '../../Models/AdminModels/aClassModel.dart';
import '../../Models/AdminModels/aStudentModel.dart';
import '../../Models/AdminModels/aTeacherModel.dart';

class AdminViewTeacherStudent extends StatefulWidget{
  final String classId;
  AdminViewTeacherStudent({required this.classId});
  @override
  State<AdminViewTeacherStudent> createState() => _AdminViewTeacherStudentPageState();
}

class _AdminViewTeacherStudentPageState extends State<AdminViewTeacherStudent>{
  final StudentController studentController = StudentController();
  final TeacherController teacherController = TeacherController();
  late String classId;

  void initState(){
    super.initState();
    classId = widget.classId;
  }

  Future<void> refresh()async{
    setState(() {
    });
  }
  void _editTeacher(String name, String id, String password, String documentId){
    final TextEditingController _teacherName = TextEditingController(text: name);
    final TextEditingController _teacherId = TextEditingController(text: id);
    final TextEditingController _teacherPassword = TextEditingController(text: password);

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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text('Techer Management', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500 ),),
                        ),
                      ]),
                  SizedBox(height: 6),
                  const Row(
                    children: [
                      Text('Create Teacher', style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w400 ),),
                    ],
                  ),
                  SizedBox(height: 10),
                  const Row(
                    children: [
                      Text('Teacher Name', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500 ),),
                    ],
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: _teacherName,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF808080))
                          ),
                          hintText: 'Enter Teacher Name',
                          hintStyle: TextStyle(color: Color(0xFF808080))
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  const Row(
                    children: [
                      Text('Teacher ID', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500 ),),
                    ],
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: _teacherId,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF808080))
                          ),
                          hintText: 'Enter Teacher ID',
                          hintStyle: TextStyle(color: Color(0xFF808080))
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  const Row(
                    children: [
                      Text('Teacher ID', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500 ),),
                    ],
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: _teacherPassword,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF808080))
                          ),
                          hintText: '*********',
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
                                  TeacherModel teacherModel = TeacherModel(
                                      id: _teacherId.text,
                                      name: _teacherName.text,
                                      password: _teacherPassword.text);

                                  teacherController.updateData(classId, documentId, teacherModel);
                                  Navigator.pop(context);
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
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
  void _editStudent(String name, String id, String password, String documentId){
    final TextEditingController _studentName = TextEditingController(text: name);
    final TextEditingController _studentID = TextEditingController(text: id);
    final TextEditingController _studentPassword = TextEditingController(text: password);

    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        builder: (BuildContext context){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                      controller: _studentPassword,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF808080))
                          ),
                          hintText: '**********',
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

                                  studentController.updateData(classId, documentId, studentModel);
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
            ),
          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(title: 'View Teacher/Students'),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdminStudent(classId: classId)
                    )
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: 70,
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
                        Text('Add', style: TextStyle(color: Colors.white),),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text('View Teachers', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500 ),),
            ],
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: refresh,
              child: StreamBuilder(
                  stream: teacherController.getTeacher(classId),
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator());
                    }if(snapshot.hasError){
                      print('Error fetching data');
                    }
                    List<TeacherModel> teachers = snapshot.data ?? [];

                    if(teachers.isEmpty){
                      return Center(child: Text('No Teachers available'));
                    }else{
                      return ListView.builder(
                          itemCount: teachers.length,
                          itemBuilder: (context, index){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: ()async{
                                  CollectionReference collection = FirebaseFirestore.instance.collection('classes').doc(classId).collection('teachers');
                                  QuerySnapshot querySnapshot = await collection.get();
                                  DocumentSnapshot documentSnapshot = querySnapshot.docs[index];

                                  String documentId = documentSnapshot.id;
                                  _editTeacher(
                                      teachers[index].name,
                                      teachers[index].id,
                                      teachers[index].password,
                                      documentId
                                  );
                                },
                                child: Card(
                                  child: ListTile(
                                    title: Text(teachers[index].name),
                                    subtitle: Text(teachers[index].id),
                                    trailing: IconButton(
                                      onPressed: ()async{
                                        CollectionReference collection = FirebaseFirestore.instance.collection('classes').doc(classId).collection('teachers');
                                        QuerySnapshot querySnapshot = await collection.get();
                                        DocumentSnapshot documentSnapshot = querySnapshot.docs[index];

                                        String documentId = documentSnapshot.id;
                                        teacherController.deleteData(classId, documentId);
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
                  }
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text('View Students', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500 ),),
            ],
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: refresh,
              child: StreamBuilder(
                  stream: studentController.getStudent(classId),
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator());
                    }if(snapshot.hasError){
                      print('Error fetching data ${snapshot.error}');
                    }

                    List<StudentModel> students = snapshot.data ?? [];

                    if(students.isEmpty){
                      return Center(child: Text('No students available'));
                    }else{
                      return ListView.builder(
                          itemCount: students.length,
                          itemBuilder: (context, index){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: ()async{
                                  CollectionReference collection = FirebaseFirestore.instance.collection('classes').doc(classId).collection('students');
                                  QuerySnapshot querySnapshot = await collection.get();
                                  DocumentSnapshot documentSnapshot = querySnapshot.docs[index];

                                  String documentId = documentSnapshot.id;
                                  _editStudent(
                                      students[index].name,
                                      students[index].id,
                                      students[index].password,
                                    documentId
                                  );
                                },
                                child: Card(
                                  child: ListTile(
                                    title: Text(students[index].name),
                                    subtitle: Text(students[index].id),
                                    trailing: IconButton(
                                        onPressed: ()async{
                                          CollectionReference collection = FirebaseFirestore.instance.collection('classes').doc(classId).collection('students');
                                          QuerySnapshot querySnapshot = await collection.get();
                                          DocumentSnapshot documentSnapshot = querySnapshot.docs[index];

                                          String documentId = documentSnapshot.id;
                                          studentController.deleteData(classId, documentId);
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
                  }
              ),
            ),
          )
        ],
      ),
    );
  }

}