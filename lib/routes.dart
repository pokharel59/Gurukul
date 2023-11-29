import 'package:flutter/material.dart';
import 'package:gurukul_mobile_app/assignment.dart';
import 'package:gurukul_mobile_app/calendar.dart';
import 'package:gurukul_mobile_app/event.dart';
import 'package:gurukul_mobile_app/home.dart';

class RouteGen{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) =>  HomePage());
      case '/Calender':
        return MaterialPageRoute(builder: (_) => CalendarPage());
      case '/Event':
        return MaterialPageRoute(builder: (_) => EventPage());
      case '/Assignment':
        return MaterialPageRoute(builder: (_) => AssignmentPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic>_errorRoute(){
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Error'),
        ),
      );
    });
  }
}