import 'package:cloud_firestore/cloud_firestore.dart';

class NoticeModel {
  // variables
  final String title;
  final String description;
  final String documentUrl;
  final DateTime currentDate;

  NoticeModel({required this.title, required this.description, required this.documentUrl, required this.currentDate});

  Map<String, dynamic> toMap(){
    return {
      'title': title,
      'description': description,
      'documentUrl': documentUrl,
      'currentDate': Timestamp.fromDate(currentDate)
    };
  }

  factory NoticeModel.fromMap(Map<String, dynamic> map){
    return NoticeModel(
        title: map['title'],
        description: map['description'],
      documentUrl: map['documentUrl'],
      currentDate: map['currentDate'].toDate()
    );
  }

}