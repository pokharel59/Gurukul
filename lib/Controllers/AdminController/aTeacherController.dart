import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gurukul_mobile_app/Models/AdminModels/aTeacherModel.dart';

class TeacherController{
  CollectionReference collectionTeacher = FirebaseFirestore.instance.collection('classes');

  Future<void> addTeacher(String docId, TeacherModel teacherModel){
    return collectionTeacher.doc(docId).collection('teachers').add(teacherModel.toMap());
  }
  
  Stream<List<TeacherModel>> getTeacher(String docId)async*{
    try{
      QuerySnapshot querySnapshot = await collectionTeacher.doc(docId).collection('teachers').get();

      yield querySnapshot.docs
          .map((doc) => TeacherModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
    }catch(e){
      print('Error fetching data $e');
    }
  }

  Future<void> deleteData(String docId, String subDocId){
    return collectionTeacher.doc(docId).collection('teachers').doc(subDocId).delete();
  }

  Future<void> updateData(String documentId, String subDocumentId, TeacherModel teacherModel){
    return collectionTeacher
        .doc(documentId)
        .collection('teachers')
        .doc(subDocumentId)
        .update(teacherModel.toMap());
  }
}