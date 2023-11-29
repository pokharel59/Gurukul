import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'assignment.dart';
import 'calendar.dart';
import 'event.dart';
import 'home.dart';

class BuildSalomonBottomBar extends StatefulWidget {
  @override
  _BuildSalomonBottomBarState createState() => _BuildSalomonBottomBarState();
}

class _BuildSalomonBottomBarState extends State<BuildSalomonBottomBar> {
  var _currentIndex = 0;

  @override
  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return CalendarPage();
      case 2:
        return AssignmentPage();
      case 3:
        return EventPage();
      default:
        return Container(); // Placeholder, you can modify this based on your needs
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPage(_currentIndex),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            selectedColor: Colors.purple,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: Icon(Icons.calendar_month),
            title: Text("Calendar"),
            selectedColor: Colors.pink,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: Icon(Icons.assignment_outlined),
            title: Text("Assignment"),
            selectedColor: Colors.orange,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.event),
            title: Text("Events"),
            selectedColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}
