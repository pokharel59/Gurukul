import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gurukul_mobile_app/Models/AdminModels/aClassModel.dart';

class ClassController{
  final CollectionReference classesCollection = FirebaseFirestore.instance.collection('classes');

  Future<void> addClass(ClassModel classModel){
    return classesCollection.add(classModel.toMap());
  }

  Stream<List<ClassModel>> getClasses(){
    return classesCollection.snapshots().map((snapshot){
      return snapshot.docs
          .map((doc) => ClassModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }
}