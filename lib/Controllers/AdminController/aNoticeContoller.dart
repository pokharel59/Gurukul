import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gurukul_mobile_app/Models/AdminModels/aNoticeModel.dart';

class NoticeController{
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('classes');

  Future<void> addNotice(String documentID, NoticeModel noticeModel){
    return collectionReference.doc(documentID).collection('notices').add(noticeModel.toMap());
  }

  Stream<List<NoticeModel>> getNotice(String documentID)async*{
    try{
      QuerySnapshot querySnapshot = await collectionReference.doc(documentID).collection('notices').get();

      yield querySnapshot.docs
          .map((notice) => NoticeModel.fromMap(notice.data() as Map<String, dynamic>))
          .toList();
    }catch(e){
      print('Error fetching data $e');
    }
  }

  Future<void> deleteNotice(String documentId, String subDocumentId){
    return collectionReference.doc(documentId).collection('notices').doc(subDocumentId).delete();
  }

  Future<void> updateNotice(String documentId, String subDocumentId, NoticeModel noticeModel) {
    return collectionReference
        .doc(documentId)
        .collection('notices')
        .doc(subDocumentId)
        .update(noticeModel.toMap());
  }
}