import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gurukul_mobile_app/Models/AdminModels/aStudentModel.dart';
import 'package:gurukul_mobile_app/Models/AdminModels/aTeacherModel.dart';

class LoginController{
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('classes');

  Future<String?> getDocumentIDByClassName(String className)async{
    QuerySnapshot querySnapshot = await collectionReference.where('className', isEqualTo: className).get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id;
    } else {
      return null; // No document found with the specified class name
    }
  }

  Future<List<StudentModel>> fetchStudentData(String documentID)async{
    try{
      QuerySnapshot querySnapshot = await collectionReference.doc(documentID).collection('students').get();

      return querySnapshot.docs
          .map((doc) => StudentModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
    }catch(e){
      print('Error fetching data $e');
      return [];
    }
  }

  Future<List<TeacherModel>> fetchSTeacherData(String documentID)async{
    try{
      QuerySnapshot querySnapshot = await collectionReference.doc(documentID).collection('teachers').get();

      return querySnapshot.docs
          .map((doc) => TeacherModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
    }catch(e){
      print('Error fetching data $e');
      return [];
    }
  }
}