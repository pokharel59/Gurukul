class TeacherModel {
  // variables
  final String id;
  final String name;
  final String password;

  TeacherModel({required this.id, required this.name, required this.password});

  Map <String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'password': password
    };
  }

  factory TeacherModel.fromMap(Map<String, dynamic> map){
    return TeacherModel(
        id: map['id'],
        name: map['name'],
        password: map['password'],
    );
    }
  }
