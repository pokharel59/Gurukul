import 'package:flutter/material.dart';
import 'package:gurukul_mobile_app/Components/adminButtonNav.dart';
import 'package:gurukul_mobile_app/Views/AdminView/aAddAsignment.dart';
import 'package:gurukul_mobile_app/Views/AdminView/aAddCalender.dart';
import 'package:gurukul_mobile_app/Views/AdminView/aAddNotice.dart';
import 'package:gurukul_mobile_app/Views/AdminView/aAddStudent.dart';
import 'package:gurukul_mobile_app/Views/AdminView/aAddTeacher.dart';
import 'package:gurukul_mobile_app/Views/AdminView/aCreateClass.dart';
import 'package:gurukul_mobile_app/Views/AdminView/aViewClass.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'Views/StudentView/sAssignment.dart';
import 'Views/StudentView/sCalendar.dart';
import 'Views/StudentView/sEvent.dart';
import 'Views/StudentView/sHome.dart';
import 'login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/adminPage',
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => MyHomePage(),
        '/adminPage': (context) => AdminViewClass(),
        '/createClass': (context) => AdminCreateClass(),
        //'/createAssignment': (context) => AdminAssignmentPage(),
        //'/createCalender': (context) => AdminCalenderPage(),
        //'/createNotice': (context) => AdminNoticePage(),
        //'/adminHome': (context) => AdminBottomNav()
        //'/createStudent': (context) => AdminStudent(),
        //'/createTeacher': (context) => AdminTeacherPageState(),
      },
      home: AdminViewClass(),
    );
  }
}

class MyHomePage extends StatefulWidget{
  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage>{
  int _currentIndex = 0;

  List _pages = [
    HomePage(),
    CalendarPage(),
    AssignmentPage(),
    EventPage(),
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: _pages[_currentIndex],
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
            onTap: (index){
              setState(() {
                _currentIndex = index;
              });
            },
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
              selectedColor: Colors.cyan,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.event),
              title: Text("Events"),
              selectedColor: Colors.deepPurple,
            ),
          ],
        ),
    );
  }
}
