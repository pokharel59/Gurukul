class AssignmentModel{
  final String title;
  final String description;
  final String subject;
  final String deadline;
  final String documentUrl;

  AssignmentModel({required this.title, required this.description, required this.subject, required this.deadline, required this.documentUrl});

  Map<String, dynamic> toMap(){
    return {
      'title': title,
      'description': description,
      'subject': subject,
      'deadline':deadline,
      'documentUrl':documentUrl
    };
  }

  factory AssignmentModel.fromMap(Map<String, dynamic> map){
    return AssignmentModel(
        title: map['title'],
        description: map['description'],
        subject: map['subject'],
        deadline: map['deadline'],
      documentUrl: map['documentUrl']
    );
  }

}