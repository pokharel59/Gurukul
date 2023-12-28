import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gurukul_mobile_app/Components/adminButtonNav.dart';
import 'package:gurukul_mobile_app/Components/customAppBar.dart';
import 'package:gurukul_mobile_app/Controllers/AdminController/aClassController.dart';
import 'package:gurukul_mobile_app/Views/AdminView/aAddStudent.dart';

import '../../Models/AdminModels/aClassModel.dart';

class AdminViewClass extends StatefulWidget{
  AdminViewClass({super.key});
  @override
  State<AdminViewClass> createState() => _AdminViewClassPageState();
}

class _AdminViewClassPageState extends State<AdminViewClass>{
  final ClassController _classController = ClassController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(title: 'View Classes'),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: (){
                Navigator.pushReplacementNamed(context, '/createClass');
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: 120,
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
                        Text('Create Class', style: TextStyle(color: Colors.white),),
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
                Text('View Classes', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500 ),),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<ClassModel>>(
              stream: _classController.getClasses(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator());
                }

                if(snapshot.hasError){
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                List<ClassModel> classes = snapshot.data ?? [];

                if(classes.isEmpty){
                  return Center(child: Text('No classes available.'));
                }

                return ListView.builder(
                  itemCount: classes.length,
                    itemBuilder: (context, index){
                      return Padding(
                          padding: const EdgeInsets.all(8),
                          child: InkWell(
                            onTap: ()async{
                              CollectionReference collection = FirebaseFirestore.instance.collection('classes');
                              QuerySnapshot querySnapshot = await collection.get();
                              DocumentSnapshot documentSnapshot = querySnapshot.docs[index];

                              String documentId = documentSnapshot.id;
                              print('documenID: $documentId');
                              print('class Name: ${classes[index].className}');
                              print('subject Name: ${classes[index].subjectName}');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AdminBottomNav(classId: documentId),
                                ),
                              );
                            },
                            child: Card(
                              child: ListTile(
                                title: Text(classes[index].className),
                                subtitle: Text('Subjects: ${classes[index].subjectName.join(", ")}'),
                                trailing: IconButton(
                                    onPressed: ()async{
                                      CollectionReference collection = FirebaseFirestore.instance.collection('classes');
                                      QuerySnapshot querySnapshot = await collection.get();
                                      DocumentSnapshot documentSnapshot = querySnapshot.docs[index];

                                      String documentId = documentSnapshot.id;
                                      _classController.deleteClass(documentId);
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
            )
          )
        ],
      ),
    );
  }

}