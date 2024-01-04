import 'package:cloud_firestore/cloud_firestore.dart';

class CalenderModel{
  final DateTime calenderDate;
  final String eventTitle;
  final String eventType;

  CalenderModel({required this.calenderDate, required this.eventTitle, required this.eventType});

  Map<String, dynamic> toMap(){
    return{
      'calenderDate': Timestamp.fromDate(calenderDate),
      'eventTitle': eventTitle,
      'eventType': eventType
    };
  }

  factory CalenderModel.fromMap(Map<String, dynamic> map){
    return CalenderModel(
        calenderDate: map['calenderDate'].toDate(),
        eventTitle: map['eventTitle'],
        eventType: map['eventType']
    );
  }
}