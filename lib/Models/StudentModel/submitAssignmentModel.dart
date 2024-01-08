class SubmitAssignmentModel{
  final String id;
  final String name;
  final String documentUrl;
  final String assignmentText;

  SubmitAssignmentModel({required this.id, required this.name, required this.documentUrl, required this.assignmentText});

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'name': name,
      'documentUrl':documentUrl,
      'assignmentTet': assignmentText
  };
}

factory SubmitAssignmentModel.fromMap(Map<String, dynamic> map){
    return SubmitAssignmentModel(
        id: map['id'],
        name: map['name'],
        documentUrl: map['documentUrl'],
        assignmentText: map['assignmentText']
    );
}
}