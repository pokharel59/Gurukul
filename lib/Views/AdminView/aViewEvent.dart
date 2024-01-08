import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gurukul_mobile_app/Components/customAppBar.dart';
import 'package:gurukul_mobile_app/Controllers/AdminController/aEventController.dart';
import 'package:gurukul_mobile_app/Models/AdminModels/aEventModel.dart';
import 'package:gurukul_mobile_app/Views/AdminView/aAddEvent.dart';
import 'package:intl/intl.dart';


import '../../Models/AdminModels/aClassModel.dart';

class AdminViewEvents extends StatefulWidget{
  final String classId;

  AdminViewEvents({required this.classId});
  @override
  State<AdminViewEvents> createState() => _AdminViewEventPageState();
}

class _AdminViewEventPageState extends State<AdminViewEvents> {
  // variables
  final EventController _eventController = EventController();
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  late String classId;

  void initState(){
    super.initState();
    classId = widget.classId;
  }

  Future<void> refresh() async {
    setState(() {});
  }

  late List<File> _files = [];
  Image? previewImage;

  void _editEvent(String title, String description, String location, String status, DateTime eventDate, String fileUrl, String subDocumentId){
    final TextEditingController eventTitle = TextEditingController(text: title);
    final TextEditingController eventDescription = TextEditingController(text: description);
    final TextEditingController eventLocation = TextEditingController(text: location);
    DateTime selectDateTime = eventDate;
    String selectedItem = status;
    List<String> subjectItemList = ['Upcoming', 'Running'];

    Future<void> _selectDatetime(BuildContext context) async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectDateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );

      if (pickedDate != null) {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(selectDateTime),
        );

        if (pickedTime != null) {
          DateTime pickedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );

          setState(() {
            selectDateTime = pickedDateTime;
          });
        }
      }
    }

    void refreshBottomSheet() {
      Navigator.pop(context);
      _editEvent(title, description, location, status, eventDate, fileUrl, subDocumentId);// Close the current bottom sheet
    }

    Future<void> getFiles() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
      if(result != null){
        _files = result.files.map((file) => File(file.path!)).toList();
        setState(() {
          previewImage = Image.file(
            _files.first,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          );
        });
      }
    }

    String _getContentType(String filePath){
      Map<String, String> contentTypeMap = {
        'pdf': 'application/pdf',
        'doc' : 'application/msword',
        'docx' : 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
        'jpeg': 'image/jpeg',
        'jpg': 'image/jpeg',
        'png': 'image/png',
      };
      String extension = filePath.split('.').last.toLowerCase();

      return contentTypeMap[extension] ?? 'application/octet-stream';
    }

    Future<void> uploadDateFiles() async {
      if (_files == null || _files.isEmpty) {
        print("No files displayed");
        return;
      }

      String downloadURLs = "";

      try {
        for (File file in _files) {
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          Reference ref = firebaseStorage.ref().child('files/$fileName');
          String contentType = _getContentType(file.path);
          SettableMetadata metadata = SettableMetadata(contentType: contentType);
          UploadTask uploadTask = ref.putFile(file, metadata);

          // Wait for the upload task to complete
          TaskSnapshot taskSnapshot = await uploadTask;

          // Get the download URL after the upload is complete
          String fileDownloadURL = await taskSnapshot.ref.getDownloadURL();
          downloadURLs = fileDownloadURL;
        }

        String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss Z').format(selectDateTime);
        if(classId.isNotEmpty && subDocumentId.isNotEmpty){
          EventModel _eventModel = EventModel(
              title: eventTitle.text,
              description: eventDescription.text,
              eventDate: formattedDate,
              location: eventLocation.text,
              eventStatus: selectedItem,
              documentUrl: downloadURLs
          );
          _eventController.updateEvent(classId, subDocumentId, _eventModel);
          Navigator.pop(context);
        }else{
          print('No documentId to update class Id: $classId document Id: $subDocumentId');
        }

        // Print the download URLs for debugging
        print("Download URLs: $fileUrl");
      } catch (e) {
        print('Error uploading files: $e');
        // Handle errors if needed
      }
    }

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        builder: (BuildContext context){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: ()async{
                      await getFiles();
                      refreshBottomSheet();
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 250,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Color(0xFFF2F2F2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 16.0),
                            child: Column(
                              children: [
                                Icon(Icons.upload_file, color: Colors.black),
                                Text('Upload Files/Image'),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child: Container(
                              height: 80,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Color(0xFFF2F2F2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: previewImage ?? Image.network(fileUrl)

                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  const Row(
                    children: [
                      Text('Event Title', style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500),),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: eventTitle,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF808080))
                          ),
                          hintText: 'Enter Title',
                          hintStyle: TextStyle(color: Color(0xFF808080))
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  const Row(
                    children: [
                      Text('Event Description', style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500),),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: eventDescription,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF808080))
                          ),
                          hintText: 'Enter Description',
                          hintStyle: TextStyle(color: Color(0xFF808080))
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Event Time', style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500),),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: (){
                            _selectDatetime(context);
                          },
                          child: Row(
                            children: [
                              Icon(Icons.calendar_month),
                              Text('Choose Date'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  const Row(
                    children: [
                      Text('Event Location', style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500),),
                    ],
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: eventLocation,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF808080))
                          ),
                          hintText: 'Enter Location',
                          hintStyle: TextStyle(color: Color(0xFF808080))
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Column(
                        children: [
                          const Text('Event Status', style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500),),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
                            child: DropdownButton<String>(
                              value: selectedItem,
                              onChanged: (String? newItem){
                                setState(() {
                                  selectedItem = newItem ?? '';
                                });
                              },
                              items: subjectItemList.map((String item){
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 20),
                  Column(
                    children: [
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: ElevatedButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white, // Background color
                                    onPrimary: Colors.black, // Text color
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Padding
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(color: Colors.black, width: 1),// Border radius
                                    ),
                                  ),
                                  child: Text('Cancel')
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: ElevatedButton(
                                  onPressed: () {
                                    uploadDateFiles();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue, // Background color
                                    onPrimary: Colors.white, // Text color
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Padding
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10), // Border radius
                                    ),
                                  ),
                                  child: Text('Create')
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )

                ],
              ),
            ),
          );
        }
    );
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
                                onTap: ()async{
                                  CollectionReference collection = FirebaseFirestore.instance.collection('classes').doc(classId).collection('events');
                                  QuerySnapshot querySnapshot = await collection.get();
                                  DocumentSnapshot documentSnapshot = querySnapshot.docs[index];

                                  String documentId = documentSnapshot.id;
                                  String eventDate = events[index].eventDate.toString();
                                  DateTime eventDateFormatted = DateFormat('yyyy-MM-dd HH:mm:ss').parse(eventDate);
                                  _editEvent(
                                      events[index].title,
                                      events[index].description,
                                      events[index].location,
                                      events[index].eventStatus,
                                      eventDateFormatted,
                                    events[index].documentUrl,
                                    documentId

                                  );
                                },
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(events[index].title),
                                      Text(events[index].description),
                                      Text(events[index].eventDate),
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