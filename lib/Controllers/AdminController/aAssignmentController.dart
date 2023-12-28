import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gurukul_mobile_app/Models/AdminModels/aAssignmentModel.dart';

class AssignmentController{
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('classes');

  Future<void> addAssignment(String documentID, AssignmentModel assignmentModel){
    return collectionReference.doc(documentID).collection('assignments').add(assignmentModel.toMap());
  }

  Stream<List<AssignmentModel>> getAssignment(String documentID)async*{
    try{
      QuerySnapshot querySnapshot = await collectionReference.doc(documentID).collection('assignments').get();

      yield querySnapshot.docs
          .map((assignment) => AssignmentModel.fromMap(assignment.data() as Map<String, dynamic>))
          .toList();
    }catch(e){
      print('Error fetching data $e');
    }
  }
}