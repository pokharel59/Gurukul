import 'package:flutter/material.dart';

class StudentCustomAppBar<T> extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final String studentName;
  final String studentId;


  StudentCustomAppBar({
    required this.title,
    required this.studentName,
    required this.studentId
  });
  @override
  Widget build(BuildContext context){
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(studentName, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 17),),
              SizedBox(height: 1),
              Text(studentId, style: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey, fontSize: 14),)
            ],
          ),
        ),
      ],
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}