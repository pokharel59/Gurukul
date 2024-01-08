import 'package:cloud_firestore/cloud_firestore.dart';

class SubmitAssignmentController {
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('classes');

  Future<void> submitAssignment(String documentId, String subDocumentId, Map<String, dynamic> newSubmittion)async{
    // try-catch block for error handling
    try {
      return await collectionReference
          .doc(documentId)
          .collection('assignments')
          .doc(subDocumentId)
          .update({'studentsSubmittion': FieldValue.arrayUnion([newSubmittion])});
    }
    catch(e) {
      print("Error updaating sunmittionArray $e");
    }
    }
  }