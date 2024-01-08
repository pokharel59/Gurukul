class ClassModel {
  // variables
  final String className;
  final List<String> subjectName;

  ClassModel({required this.className, required this.subjectName,}); //required this.teachers

  Map<String, dynamic> toMap(){
    return {
      'className': className,
      'subjectName': subjectName,
    };
  }

  factory ClassModel.fromMap(Map<String, dynamic> map){
    return ClassModel(
        className: map['className'],
        subjectName: List<String>.from(map['subjectName'] ?? []),
    );
  }
}