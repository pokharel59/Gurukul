import 'package:flutter/material.dart';
import 'package:gurukul_mobile_app/Components/messageToast.dart';
import 'package:gurukul_mobile_app/Controllers/AdminController/aClassController.dart';
import 'package:gurukul_mobile_app/Models/AdminModels/aClassModel.dart';
import '../../Components/customAppBar.dart';

class AdminCreateClass extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AdminCreateClassPageState();
}

class _AdminCreateClassPageState extends State<AdminCreateClass>{
  final TextEditingController classNameController = TextEditingController();
  final ClassController _classController = ClassController();
  final List<TextEditingController> subjectControllers = [];
  Toaster showMessage = Toaster();

  @override
  void initState(){
    super.initState();
    subjectControllers.add(TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(title: 'Add Classes'),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                                  //Navigator.pop(context);
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

                                  _classController.addClass(newClass);
                                  classNameController.clear();
                                  subjectControllers.clear();
                                  //Navigator.pop(context);
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
}



