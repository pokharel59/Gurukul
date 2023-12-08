import 'package:flutter/material.dart';
import 'package:gurukul_mobile_app/assignment.dart';
import 'package:gurukul_mobile_app/calendar.dart';
import 'package:gurukul_mobile_app/event.dart';
import 'package:gurukul_mobile_app/home.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
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
        '/home': (context) => MyHomePage(),
      },
      home: LoginPage(),
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
