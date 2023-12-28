import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gurukul_mobile_app/Components/customAppBar.dart';
import 'package:gurukul_mobile_app/Controllers/AdminController/aAssignmentController.dart';
import 'package:gurukul_mobile_app/Controllers/AdminController/aEventController.dart';
import 'package:gurukul_mobile_app/Models/AdminModels/aAssignmentModel.dart';
import 'package:gurukul_mobile_app/Models/AdminModels/aEventModel.dart';

class AdminEventPage extends StatefulWidget{
  final String classID;

  AdminEventPage({required this.classID});

  @override
  State<AdminEventPage> createState() => _AdminEventPageState();
}

class _AdminEventPageState extends State<AdminEventPage>{
  late String classId;
  final TextEditingController eventTitle = TextEditingController();
  final TextEditingController eventDescription = TextEditingController();
  final TextEditingController eventLocation = TextEditingController();
  final EventController eventController = EventController();

  void initState(){
    super.initState();
    classId = widget.classID;
  }

  String selectedItem = 'Running';
  List<String> subjectItemList = ['Upcoming', 'Running'];
  DateTime selectDateTime = DateTime.now();

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

  Future<void> getFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: CustomAppBar(title: 'Add Event'),
        body: Padding(
          padding: const EdgeInsets.only(top: 25.0, right: 14.0, left: 14.0),
          child: Column(
            children: [
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
                  Text('$selectDateTime'),
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
                  GestureDetector(
                    onTap: (){
                      getFiles();
                    },
                    child: Container(
                      width: 500,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: Column(
                          children: [
                            Icon(Icons.upload_file, color: Colors.black),
                            Text('Upload Files/Image'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ElevatedButton(
                              onPressed: (){

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
                                EventModel eventModel = EventModel(
                                    title: eventTitle.text,
                                    description: eventDescription.text,
                                    eventDate: selectDateTime.day,
                                    location: eventLocation.text,
                                    eventStatus: selectedItem
                                );

                                eventController.addEvent(classId, eventModel);
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
        )
    );
  }

}