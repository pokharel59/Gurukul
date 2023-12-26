import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gurukul_mobile_app/Components/customAppBar.dart';
import 'package:gurukul_mobile_app/Controllers/AdminController/aTeacherController.dart';
import 'package:gurukul_mobile_app/Models/AdminModels/aTeacherModel.dart';
import 'package:gurukul_mobile_app/Views/AdminView/aAddStudent.dart';

class AdminTeacher extends StatefulWidget{
  final String classId;

  AdminTeacher({required this.classId});
  @override
  State<StatefulWidget> createState() => _AdminTeacherPageState();
}

class _AdminTeacherPageState extends State<AdminTeacher>{
  final TextEditingController _teacherName = TextEditingController();
  final TextEditingController _teacherId = TextEditingController();
  final TextEditingController _teacherPassword = TextEditingController();
  final TeacherController teacherController = TeacherController();
  late String classId;

  @override
  void initState(){
    super.initState();
    classId = widget.classId;
}


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(title: 'Add Teacher'),
        body: Padding(
          padding: EdgeInsets.only(right: 5.0, left: 15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminStudent(classId: classId)
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
                                Icon(Icons.people, size: 30,),
                                Text('Student')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
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
                              Icon(Icons.people_alt_outlined, size: 30,),
                              Text('Teacher')
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
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
                  Text('Teacher Password', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500 ),),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 50,
                child: TextField(
                  controller: _teacherPassword,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF808080))
                      ),
                      hintText: 'Enter Teacher Password',
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

                              teacherController.addTeacher(classId, teacherModel);
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
              SizedBox(height: 10),
                  Row(
                    children: [
                      Text('View Teachers', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500 ),),
                    ],
                  ),
                  Expanded(
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
                                        ),
                                      ),
                                    );
                                }
                            );
                          }
                        }
                    ),
                  )
            ],
          ),
        )
    );
  }

}
