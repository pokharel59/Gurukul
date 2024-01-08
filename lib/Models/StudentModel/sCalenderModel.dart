import 'package:cloud_firestore/cloud_firestore.dart';

class StudentCalenderModel {
  // variables
  final DateTime calenderDate;
  final String eventTitle;
  final String eventType;

  StudentCalenderModel({required this.calenderDate, required this.eventTitle, required this.eventType});

  Map<String, Object?> toMap(){
    return{
      'calenderDate': Timestamp.fromDate(calenderDate),
      'eventTitle': eventTitle,
      'eventType': eventType
    };
  }

  factory StudentCalenderModel.fromMap(DocumentSnapshot<Map<String, dynamic>> snapshot,
      [SnapshotOptions? options]) {
    final data = snapshot.data()!;
    return StudentCalenderModel(
        calenderDate: data['calenderDate'].toDate(),
        eventTitle: data['eventTitle'],
        eventType: data['eventType']
    );
  }
}