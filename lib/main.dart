import 'package:flutter/material.dart';
import 'package:gurukul_mobile_app/Views/AdminView/aCreateClass.dart';
import 'package:gurukul_mobile_app/Views/AdminView/aViewClass.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'Views/StudentView/sAssignment.dart';
import 'Views/StudentView/sCalendar.dart';
import 'Views/StudentView/sEvent.dart';
import 'Views/StudentView/sHome.dart';
import 'Views/StudentView/sNotice.dart';
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
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        //'/home': (context) => MyHomePage(),
        '/adminPage': (context) => AdminViewClass(),
        '/createClass': (context) => AdminCreateClass()
        //'/adminHome': (context) => AdminBottomNav(),
      },
      home: LoginPage(),

    );
  }
}

class MyHomePage extends StatefulWidget{
  final String classId;
  final String studentName;
  final String studentID;

  MyHomePage({required this.classId, required this.studentName, required this.studentID});
  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage>{
  int _currentIndex = 0;
  late String classId;
  late String studentName;
  late String studentID;
  late List<Widget> _pages;

  void initState(){
    super.initState();
    classId = widget.classId;
    studentName = widget.studentName;
    studentID = widget.studentID;
    studentName = widget.studentName;
    studentID = widget.studentID;
    _pages = [
      HomePage(classId: classId, studentName: studentName, studentID: studentID),
      CalendarPage(classId: classId, studentName: studentName, studentID: studentID),
      AssignmentPage(classId: classId, studentName: studentName, studentID: studentID),
      EventPage(),
      NoticePage(classId: classId, studentName: studentName, studentID: studentID)
    ];
  }

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
            SalomonBottomBarItem(
              icon: Icon(Icons.notifications),
              title: Text("Notice"),
              selectedColor: Colors.deepPurple,
            ),
          ],
        ),
    );
  }
}
