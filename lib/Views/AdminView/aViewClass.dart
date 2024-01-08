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

  void editClass(String className, List<String> subjects, String documentId){
    final TextEditingController classNameController = TextEditingController(text: className);
    final List<TextEditingController> subjectControllers = [];

    for(String subject in subjects){
      subjectControllers.add(TextEditingController(text: subject));
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
            padding: const EdgeInsets.all(20.0),
            child: Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 10),
                    const Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Class Management', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),),
                            Text('Create Class', style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w400 ),),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    const Row(
                      children: [
                        Text('Class Name', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500 ),),
                      ],
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: classNameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF808080))
                          ),
                          hintText: 'Enter Class Name',
                          hintStyle: TextStyle(color: Color(0xFF808080))
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 10),
                        const Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Subject Management', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),),
                                Text('Create Subject', style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w400 ),),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        const Row(
                          children: [
                            Text('Subject Name', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500 ),),
                          ],
                        ),
                        SizedBox(height: 10),
                        SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              Column(
                                  children: List.generate(
                                      subjectControllers.length,
                                          (index) => Padding(
                                        padding: const EdgeInsets.only(bottom: 10.0),
                                        child: TextField(
                                          controller: subjectControllers[index],
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Color(0xFF808080))
                                              ),
                                              hintText: 'Enter Subject Name',
                                              hintStyle: TextStyle(color: Color(0xFF808080))
                                          ),
                                        ),
                                      )
                                  )

                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
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
                                      //Navigator.pushReplacementNamed(context, '/createStudent');
                                      List<String> subjects = subjectControllers
                                          .map((controller) => controller.text)
                                          .toList();

                                      print('Subject: $subjects');
                                      ClassModel newClass = ClassModel(
                                        className: classNameController.text,
                                        subjectName: subjects,
                                        //subjectName: subjects,
                                      );

                                      _classController.updateClass(documentId, newClass);
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
                                    child: Text('Edit')
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        TextButton(
                          onPressed: (){
                            setState(() {
                              subjectControllers.add(TextEditingController());
                            });
                          },
                          child: Text('Add More Subjects'),
                        )
                      ],
                    ),
                  ],
                ),
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

                if(classes == null){
                  return Center(child: CircularProgressIndicator());
                }

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
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () async{
                                          CollectionReference collection = FirebaseFirestore.instance.collection('classes');
                                          QuerySnapshot querySnapshot = await collection.get();
                                          DocumentSnapshot documentSnapshot = querySnapshot.docs[index];

                                          String documentId = documentSnapshot.id;
                                          editClass(
                                              classes[index].className,
                                              classes[index].subjectName,
                                              documentId
                                          );
                                        },
                                        icon: Icon(Icons.edit)
                                    ),
                                    IconButton(
                                            onPressed: () async{
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext context){
                                                    return AlertDialog(
                                                      title: Text('Delete Class'),
                                                      content: Text('Do you really want to delete class?'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () => Navigator.pop(context, 'Cancel'),
                                                          child: const Text('Cancel'),
                                                        ),
                                                        TextButton(
                                                          onPressed: ()async{
                                                            CollectionReference collection = FirebaseFirestore.instance.collection('classes');
                                                            QuerySnapshot querySnapshot = await collection.get();
                                                            DocumentSnapshot documentSnapshot = querySnapshot.docs[index];

                                                            String documentId = documentSnapshot.id;
                                                            _classController.deleteClass(documentId);
                                                            Navigator.pop(context);
                                                          },
                                                          child: const Text('OK'),
                                                        ),
                                                      ],
                                                    );
                                                  }
                                              );

                                            },
                                            icon: Icon(Icons.delete)
                                        ),
                                  ],
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