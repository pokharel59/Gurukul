import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gurukul_mobile_app/Components/customAppBar.dart';

class AdminTeacherPage extends StatefulWidget{
  const AdminTeacherPage({super.key});

  @override
  State<AdminTeacherPage> createState() => _AdminTeacherPageState();
}

class _AdminTeacherPageState extends State<AdminTeacherPage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: CustomAppBar(title: 'Add Teacher'),
        body: Padding(
          padding: EdgeInsets.only(right: 15.0, left: 15.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 25.0),
                    child: Text('Techer Management', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500 ),),
                  ),
                ]),
              SizedBox(height: 6),
              Row(
                children: [
                  Text('Create Teacher', style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w400 ),),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('Teacher Name', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500 ),),
                ],
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF808080))
                    ),
                    hintText: 'Enter Teacher Name',
                    hintStyle: TextStyle(color: Color(0xFF808080))
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('Teacher ID', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500 ),),
                ],
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF808080))
                    ),
                    hintText: 'Enter Teacher ID',
                    hintStyle: TextStyle(color: Color(0xFF808080))
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('Teacher Password', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500 ),),
                ],
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF808080))
                    ),
                    hintText: 'Enter Teacher Password',
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
                      Text('View Teachers', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500 ),),
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