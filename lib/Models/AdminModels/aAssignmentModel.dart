class AssignmentModel {
  // variables
  final String title;
  final String description;
  final String subject;
  final String deadline;
  final String documentUrl;
  final List<String> studentSubmittion;

  AssignmentModel({required this.title, required this.description, required this.subject, required this.deadline, required this.documentUrl, required this.studentSubmittion});

  Map<String, dynamic> toMap(){
    return {
      'title': title,
      'description': description,
      'subject': subject,
      'deadline':deadline,
      'documentUrl':documentUrl,
      'studentsSubmittion': studentSubmittion
    };
  }

  factory AssignmentModel.fromMap(Map<String, dynamic> map){
    return AssignmentModel(
        title: map['title'],
        description: map['description'],
        subject: map['subject'],
        deadline: map['deadline'],
      documentUrl: map['documentUrl'],
      studentSubmittion: List<String>.from(map['studentSubmittion'] ?? [])
    );
  }

}