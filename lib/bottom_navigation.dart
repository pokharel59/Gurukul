import 'package:flutter/material.dart';
import 'package:gurukul_mobile_app/assignment.dart';
import 'package:gurukul_mobile_app/home.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'calendar.dart';
import 'event.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static final title = 'salomon_bottom_bar';

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List pages = [
    HomePage(),
    CalendarPage(),
    AssignmentPage(),
    EventPage(),
  ];


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyApp.title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(MyApp.title),
        ),
        bottomNavigationBar: buildSalomonBottomBar(),
      ),
    );
  }
}

SalomonBottomBar buildSalomonBottomBar() {
  var currentIndex = 0;


  return SalomonBottomBar(
    currentIndex: currentIndex,
    //onTap: (i) => setState(() => _currentIndex = i),
    items: [
      SalomonBottomBarItem(
        icon: Icon(Icons.home),
        title: Text("Home"),
        selectedColor: Colors.purple,
      ),
      SalomonBottomBarItem(
        icon: Icon(Icons.calendar_month),
        title: Text("Calendar"),
        selectedColor: Colors.pink,
      ),
      SalomonBottomBarItem(
        icon: Icon(Icons.assignment),
        title: Text("Assignment"),
        selectedColor: Colors.orange,

      ),
      SalomonBottomBarItem(
        icon: Icon(Icons.event),
        title: Text("Events"),
        selectedColor: Colors.teal,
      ),
    ],
  );
}
