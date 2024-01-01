import 'package:flutter/material.dart';
import 'package:gurukul_mobile_app/Views/AdminView/aAddAsignment.dart';
import 'package:gurukul_mobile_app/Views/AdminView/aAddCalender.dart';
import 'package:gurukul_mobile_app/Views/AdminView/aAddStudent.dart';
import 'package:gurukul_mobile_app/Views/AdminView/aAddTeacher.dart';
import 'package:gurukul_mobile_app/Views/AdminView/aViewAssignment.dart';
import 'package:gurukul_mobile_app/Views/AdminView/aViewCalender.dart';
import 'package:gurukul_mobile_app/Views/AdminView/aViewEvent.dart';
import 'package:gurukul_mobile_app/Views/AdminView/aViewNotice.dart';
import 'package:gurukul_mobile_app/Views/AdminView/viewTeacherStudent.dart';

import '../Views/AdminView/aAddNotice.dart';

class AdminBottomNav extends StatefulWidget {
  final String classId;

  AdminBottomNav({required this.classId});
  @override
  _AdminBottomNavState createState() => _AdminBottomNavState();
}

class _AdminBottomNavState extends State<AdminBottomNav> {
  int _currentIndex = 0;
  late String classId;
  late List<Widget> _pages;

  void initState(){
    super.initState();
    classId = widget.classId;
     _pages = [
      AdminViewNotice(classId: classId),
      AdminViewAssignments(classId: classId),
       AdminViewEvents(classId: classId),
      ViewCalender(classId: classId),
       AdminViewTeacherStudent(classId: classId)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_add, color: Colors.black,),
            label: 'Page 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment, color: Colors.black),
            label: 'Page 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event, color: Colors.black),
            label: 'Page 3',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month, color: Colors.black),
            label: 'Page 4',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_rounded, color: Colors.black),
            label: 'Page 5',
          ),
        ],
      ),
    );
  }
}
