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