class AssignmentModel{
  final String title;
  final String description;
  final String subject;
  final String deadline;

  AssignmentModel({required this.title, required this.description, required this.subject, required this.deadline});

  Map<String, dynamic> toMap(){
    return {
      'title': title,
      'description': description,
      'subject': subject,
      'deadline':deadline
    };
  }

  factory AssignmentModel.fromMap(Map<String, dynamic> map){
    return AssignmentModel(
        title: map['title'],
        description: map['description'],
        subject: map['subject'],
        deadline: map['deadline']
    );
  }

}