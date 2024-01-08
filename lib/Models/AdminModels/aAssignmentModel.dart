import 'package:cloud_firestore/cloud_firestore.dart';

class AssignmentModel{
  final String title;
  final String description;
  final String subject;
  final DateTime deadline;
  final String documentUrl;
  final List<Map<String, dynamic>> studentsSubmittion;
  final DateTime date;

  AssignmentModel({required this.title, required this.description, required this.subject, required this.deadline, required this.documentUrl, required this.studentsSubmittion, required this.date});

  Map<String, dynamic> toMap(){
    return {
      'title': title,
      'description': description,
      'subject': subject,
      'deadline':Timestamp.fromDate(deadline),
      'documentUrl':documentUrl,
      'studentsSubmittion': studentsSubmittion,
      'date': Timestamp.fromDate(date)
    };
  }

  factory AssignmentModel.fromMap(Map<String, dynamic> map){
    return AssignmentModel(
        title: map['title'],
        description: map['description'],
        subject: map['subject'],
        deadline: map['deadline'].toDate(),
      documentUrl: map['documentUrl'],
      studentsSubmittion: List<Map<String, dynamic>>.from(map['studentsSubmittion'] ?? []),
      date: map['date'].toDate()
    );
  }

}