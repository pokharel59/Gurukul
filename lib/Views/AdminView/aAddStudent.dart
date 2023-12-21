import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gurukul_mobile_app/Components/customAppBar.dart';

class AdminStudentPage extends StatefulWidget{
  const AdminStudentPage({super.key});

  @override
  State<AdminStudentPage> createState() => _AdminStudentPageState();
}

class _AdminStudentPageState extends State<AdminStudentPage>{
  Future<void> getFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: CustomAppBar(title: 'Add Student'),
        body: Padding(
          padding: EdgeInsets.only(right: 15.0, left: 15.0),
          child: Column(
            children: [
              Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 25.0),
                      child: Text('Student Management', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500 ),),
                    ),
                  ]),
              SizedBox(height: 6),
              Row(
                children: [
                  Text('Create Student', style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w400 ),),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('Student Name', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500 ),),
                ],
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF808080))
                    ),
                    hintText: 'Enter Student Name',
                    hintStyle: TextStyle(color: Color(0xFF808080))
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('Student ID', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500 ),),
                ],
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF808080))
                    ),
                    hintText: 'Enter Student ID',
                    hintStyle: TextStyle(color: Color(0xFF808080))
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('Student Password', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500 ),),
                ],
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF808080))
                    ),
                    hintText: 'Enter Student Password',
                    hintStyle: TextStyle(color: Color(0xFF808080))
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ElevatedButton(
                          onPressed: (){

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
              SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    children: [
                      Text('View Students', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500 ),),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
                    child: SizedBox(
                      height: 70,
                      width: 360,
                      child: Card(
                        child: ListTile(
                          leading: Text('Welcome'),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
    );
  }

}