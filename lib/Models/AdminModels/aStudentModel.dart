class StudentModel {
  // variables
  final String name;
  final String id;
  final String password;

  StudentModel({required this.name, required this.id, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'password': password
     };
    }

  factory StudentModel.fromMap(Map<String, dynamic> map){
    return StudentModel(
        name: map['name'],
        id: map['id'],
        password: map['password']
    );
  }
}