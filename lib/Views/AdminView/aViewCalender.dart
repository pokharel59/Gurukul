import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gurukul_mobile_app/Components/customAppBar.dart';
import 'package:gurukul_mobile_app/Views/AdminView/aAddCalender.dart';
import 'package:intl/intl.dart';
import '../../Controllers/AdminController/aCalenderController.dart';
import '../../Models/AdminModels/aCalenderModel.dart';

class ViewCalender extends StatefulWidget {
  // variable
  final String classId;
  
  ViewCalender({required this.classId});
  @override
  State<ViewCalender> createState() => _ViewCalenderState();
  
}

class _ViewCalenderState extends State<ViewCalender>{
  final CalenderController calenderController = CalenderController();
  late String classId;

  // init method
  void initState(){
    super.initState();
    classId = widget.classId;
  }

  Future<void> refresh() async {
    setState(() {});
  }

  void editCalender(String title, String type, DateTime date, String subDocumentId){
    final TextEditingController eventTitle = TextEditingController(text: title);

    String selectedItem = type;
    List<String> eventItemList = ['Deadline', 'Holiday', 'Event'];
    DateTime selectDateTime = date;

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
            padding: const EdgeInsets.only(top: 25.0, right: 14.0, left: 14.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                    Text('$date'),
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
                                  //String formattedDate = DateFormat("yyyy-MM-dd HH:mm:ss").format(selectDateTime);
                                  CalenderModel calenderModel = CalenderModel(
                                      calenderDate: selectDateTime,
                                      eventTitle: eventTitle.text,
                                      eventType: selectedItem
                                  );

                                  calenderController.updateCalender(classId, subDocumentId, calenderModel);
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
                                child: Text('Edit')
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )

              ],
            ),
          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(title: 'View Calender'),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => AdminCalenderPage(classId: classId))
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
                        Text('Add Calender', style: TextStyle(color: Colors.white),),
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
                Text('View Calender', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500 ),),
              ],
            ),
          ),
          Expanded(
              child: RefreshIndicator(
                onRefresh: refresh,
                child: StreamBuilder<List<CalenderModel>>(
                    stream: calenderController.getCalenderEvent(classId),
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator());
                      }

                      if(snapshot.hasError){

                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      List<CalenderModel> events = snapshot.data ?? [];

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
                                  CollectionReference collection = FirebaseFirestore.instance.collection('classes').doc(classId).collection('academicCalender');
                                  QuerySnapshot querySnapshot = await collection.get();
                                  DocumentSnapshot documentSnapshot = querySnapshot.docs[index];

                                  String documentId = documentSnapshot.id;
                                  //DateTime formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(events[index].calenderDate);
                                  editCalender(
                                      events[index].eventTitle,
                                      events[index].eventType,
                                      events[index].calenderDate,
                                      documentId
                                  );
                                },
                                child: Card(
                                  child: ListTile(
                                    leading: Text(events[index].calenderDate.toString()),
                                    title: Text(events[index].eventTitle),
                                    subtitle: Text(events[index].eventType),
                                    trailing: IconButton(
                                      onPressed: ()async{
                                        CollectionReference collection = FirebaseFirestore.instance.collection('classes').doc(classId).collection('academicCalender');
                                        QuerySnapshot querySnapshot = await collection.get();
                                        DocumentSnapshot documentSnapshot = querySnapshot.docs[index];

                                        String documentId = documentSnapshot.id;
                                        calenderController.deleteCalender(classId, documentId);
                                        refresh();
                                      },
                                      icon: Icon(Icons.delete),),
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