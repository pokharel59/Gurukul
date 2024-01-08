import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gurukul_mobile_app/Models/AdminModels/aStudentModel.dart';

class StudentController {
  CollectionReference collection = FirebaseFirestore.instance.collection('classes');

  Future<void> addStudent(String documentID, StudentModel studentModel) {
    return collection.doc(documentID).collection('students').add(studentModel.toMap());
  }

  Stream<List<StudentModel>> getStudent(String documentID) async* {
    // try-catch block for error handling
    try {
      QuerySnapshot querySnapshot = await collection.doc(documentID).collection('students').get();

      yield querySnapshot.docs
          .map((doc) => StudentModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
    }
    catch(e){
      print('Error fetching data $e');
    }
  }
  Future<void> deleteData(String docId, String subDocId){
    return collection.doc(docId).collection('students').doc(subDocId).delete();
  }

  Future<void> updateData(String documentId, String subDocumentId, StudentModel studentModel){
    return collection
        .doc(documentId)
        .collection('students')
        .doc(subDocumentId)
        .update(studentModel.toMap());
  }
}