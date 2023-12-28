import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gurukul_mobile_app/Components/customAppBar.dart';
import 'package:gurukul_mobile_app/Controllers/AdminController/aAssignmentController.dart';
import 'package:gurukul_mobile_app/Controllers/AdminController/aClassController.dart';
import 'package:gurukul_mobile_app/Models/AdminModels/aAssignmentModel.dart';
import 'package:gurukul_mobile_app/Views/AdminView/aAddAsignment.dart';
import 'package:gurukul_mobile_app/Views/AdminView/aAddStudent.dart';

import '../../Models/AdminModels/aClassModel.dart';

class AdminViewAssignments extends StatefulWidget{
  final String classId;

  AdminViewAssignments({required this.classId});
  @override
  State<AdminViewAssignments> createState() => _AdminViewAssignmentPageState();
}

class _AdminViewAssignmentPageState extends State<AdminViewAssignments>{
  final AssignmentController _assignmentController = AssignmentController();

  late String classId;

  void initState(){
    super.initState();
    classId = widget.classId;
  }

  Future<void> refresh()async {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(title: 'View Assignments'),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminAssignmentPage(classID: classId),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: 160,
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
                        Text('Create Assignment', style: TextStyle(color: Colors.white),),
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
                Text('View Assignments', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500 ),),
              ],
            ),
          ),
          Expanded(
              child: RefreshIndicator(
                onRefresh: refresh,
                child: StreamBuilder<List<AssignmentModel>>(
                    stream: _assignmentController.getAssignment(classId),
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
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: InkWell(
                                onTap: (){
                                },
                                child: Card(
                                  child: ListTile(
                                    leading: Text(assignments[index].deadline),
                                    title: Text(assignments[index].title),
                                    subtitle: Text(assignments[index].description),
                                    trailing: IconButton(
                                      onPressed: ()async{
                                        CollectionReference collection = FirebaseFirestore.instance.collection('classes').doc(classId).collection('assignments');
                                        QuerySnapshot querySnapshot = await collection.get();
                                        DocumentSnapshot documentSnapshot = querySnapshot.docs[index];

                                        String documentId = documentSnapshot.id;
                                        _assignmentController.deleteAssignment(classId, documentId);
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