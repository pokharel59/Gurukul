import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gurukul_mobile_app/Components/customAppBar.dart';
import 'package:gurukul_mobile_app/Controllers/AdminController/aAssignmentController.dart';
import 'package:gurukul_mobile_app/Controllers/AdminController/aClassController.dart';
import 'package:gurukul_mobile_app/Controllers/AdminController/aEventController.dart';
import 'package:gurukul_mobile_app/Models/AdminModels/aAssignmentModel.dart';
import 'package:gurukul_mobile_app/Models/AdminModels/aEventModel.dart';
import 'package:gurukul_mobile_app/Views/AdminView/aAddAsignment.dart';
import 'package:gurukul_mobile_app/Views/AdminView/aAddEvent.dart';
import 'package:gurukul_mobile_app/Views/AdminView/aAddStudent.dart';

import '../../Models/AdminModels/aClassModel.dart';

class AdminViewEvents extends StatefulWidget{
  final String classId;

  AdminViewEvents({required this.classId});
  @override
  State<AdminViewEvents> createState() => _AdminViewEventPageState();
}

class _AdminViewEventPageState extends State<AdminViewEvents>{
  final EventController _eventController = EventController();

  late String classId;

  void initState(){
    super.initState();
    classId = widget.classId;
  }

  Future<void> refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(title: 'View Events'),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminEventPage(classID: classId),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: 130,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Colors.white,),
                        Text('Create Event', style: TextStyle(color: Colors.white),),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text('View Events', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500 ),),
              ],
            ),
          ),
          Expanded(
              child: RefreshIndicator(
                onRefresh: refresh,
                child: StreamBuilder<List<EventModel>>(
                    stream: _eventController.getEvent(classId),
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator());
                      }

                      if(snapshot.hasError){

                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      List<EventModel> events = snapshot.data ?? [];

                      if(events.isEmpty){
                        return Center(child: Text('No events available.'));
                      }

                      return ListView.builder(
                          itemCount: events.length,
                          itemBuilder: (context, index){
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: InkWell(
                                onTap: (){
                                },
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(events[index].title),
                                      Text(events[index].description),
                                      Text(events[index].eventDate.toString()),
                                      Text(events[index].location),
                                      Text(events[index].eventStatus),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          IconButton(
                                              onPressed: ()async{
                                                CollectionReference collection = FirebaseFirestore.instance.collection('classes').doc(classId).collection('events');
                                                QuerySnapshot querySnapshot = await collection.get();
                                                DocumentSnapshot documentSnapshot = querySnapshot.docs[index];

                                                String documentId = documentSnapshot.id;
                                                _eventController.deleteEvent(classId, documentId);
                                                refresh();
                                              },
                                              icon: Icon(Icons.delete)
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                      );
                    }
                ),
              )
          )
        ],
      ),
    );
  }

}