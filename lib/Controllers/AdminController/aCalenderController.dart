import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gurukul_mobile_app/Models/AdminModels/aCalenderModel.dart';

class CalenderController{
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('classes');

  Future<void> addCalenderEvent(String documentId, CalenderModel calenderModel){
    return collectionReference.doc(documentId).collection('academicCalender').add(calenderModel.toMap());
  }

  Stream<List<CalenderModel>> getCalenderEvent(String documentId)async*{
    try{
      QuerySnapshot querySnapshot = await collectionReference.doc(documentId).collection('academicCalender').get();

      yield querySnapshot.docs
          .map((calenders) => CalenderModel.fromMap(calenders.data() as Map<String, dynamic>))
          .toList();
    }catch(e){
      print('Error fetching data: $e');
    }
  }

  Future<void> deleteCalender(String documentId, String subDocumentId){
    return collectionReference.doc(documentId).collection('academicCalender').doc(subDocumentId).delete();
  }

  Future<void> updateCalender(String documentId, String subDocumentId, CalenderModel updateCalender) {
    return collectionReference
        .doc(documentId)
        .collection('academicCalender')
        .doc(subDocumentId)
        .update(updateCalender.toMap());
  }
}