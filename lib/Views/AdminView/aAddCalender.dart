import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gurukul_mobile_app/Components/customAppBar.dart';
import 'package:gurukul_mobile_app/Controllers/AdminController/aCalenderController.dart';
import 'package:gurukul_mobile_app/Models/AdminModels/aCalenderModel.dart';
import 'package:intl/intl.dart';

class AdminCalenderPage extends StatefulWidget{
  final String classId;

  AdminCalenderPage({required this.classId});

  @override
  State<AdminCalenderPage> createState() => _AdminCalenderPageState();
}

class _AdminCalenderPageState extends State<AdminCalenderPage> {
  // variables
  final TextEditingController eventTitle = TextEditingController();
  final CalenderController calenderController = CalenderController();
  String selectedItem = 'Deadline';
  List<String> eventItemList = ['Deadline', 'Holiday', 'Event'];
  DateTime selectDateTime = DateTime.now();
  late String classId;

  // init method
  void initState(){
    super.initState();
    classId = widget.classId;
  }

  Future<void> _selectDatetime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    // condition check
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: CustomAppBar(title: 'Add Calender'),
        body: Padding(
          padding: const EdgeInsets.only(top: 25.0, right: 14.0, left: 14.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Calender', style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500),),
                  Text('Add Event', style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.w500),),
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
              SizedBox(height: 15),
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
              Text('Choose a date first', style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.w500),),
              const SizedBox(height: 15),
              Row(
                children: [
                  Column(
                    children: [
                      const Text('Event Type', style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500),),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 3.0, right: 10.0),
                        child: DropdownButton<String>(
                          value: selectedItem,
                          onChanged: (String? newItem){
                            setState(() {
                              selectedItem = newItem ?? '';
                            });
                          },
                          items: eventItemList.map((String item){
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                      Text('Choose a event first', style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.w500),),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
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
                                //String formattedDate = DateFormat("yyyy-MM-dd HH:mm:ss").format(selectDateTime);
                                CalenderModel calenderModel = CalenderModel(
                                    calenderDate: selectDateTime,
                                    eventTitle: eventTitle.text,
                                    eventType: selectedItem
                                );

                                calenderController.addCalenderEvent(classId, calenderModel);
                                eventTitle.clear();
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