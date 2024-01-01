import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gurukul_mobile_app/Models/AdminModels/aEventModel.dart';

class EventController{
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('classes');

  Future<void> addEvent(String docId, EventModel eventModel){
    return collectionReference.doc(docId).collection('events').add(eventModel.toMap());
  }

  Stream<List<EventModel>> getEvent(String docId)async*{
    try{
      QuerySnapshot querySnapshot = await collectionReference.doc(docId).collection('events').get();

      yield querySnapshot.docs
          .map((event) => EventModel.fromMap(event.data() as Map<String, dynamic>))
          .toList();
    }catch(e){
      print('Error fetching data $e');
    }
  }

  Future<void> deleteEvent(String documentId, String subDocumentId){
    return collectionReference.doc(documentId).collection('events').doc(subDocumentId).delete();
  }

  Future<void> updateEvent(String documentId, String subDocumentId, EventModel updateEvent) {
    return collectionReference
        .doc(documentId)
        .collection('events')
        .doc(subDocumentId)
        .update(updateEvent.toMap());
  }
}