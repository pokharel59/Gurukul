import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gurukul_mobile_app/Components/studentCustomAppBar.dart';
import 'package:gurukul_mobile_app/Controllers/AdminController/aCalenderController.dart';
import 'package:gurukul_mobile_app/Models/AdminModels/aCalenderModel.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../Models/StudentModel/sCalenderModel.dart';

class CalendarPage extends StatefulWidget {
  final String classId;

  const CalendarPage({required this.classId});
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final CalenderController calenderController = CalenderController();
  var orange_color = Color(0xfff04d22);
  var primary_color = Color(0xffbe00fe);
  var grey_color = Colors.grey;
  late String classId;

  late MarkerBuilder? markerBuilder;

  late Map<DateTime, List<StudentCalenderModel>> _events;

  DateTime today = DateTime.now();

  void initState() {
    super.initState();
    classId = widget.classId;
    _events = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    );
    _fetchCalenderData();
  }

  int getHashCode(DateTime key){
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  Future<void> _fetchCalenderData() async {
    final snap = await FirebaseFirestore.instance.collection('classes').doc(classId).collection('academicCalender').withConverter(
        fromFirestore: StudentCalenderModel.fromMap,
        toFirestore: (calender, options) => calender.toMap()).get();
    for (var doc in snap.docs) {
      final calender = doc.data();
      final day = DateTime.utc(calender.calenderDate.year, calender.calenderDate.month, calender.calenderDate.day);
      if (_events[day] == null) {
        _events[day] = [];
      }
      _events[day]!.add(calender);
    }
    setState(() {});
  }

  List _getEvents(DateTime day){
    return _events[day] ?? [];
  }

  void _onDaySelected(DateTime day, DateTime focus) {
    setState(() {
      today = day;
    });
  }

  Future<void> refresh() async {
    setState(() {});
  }

  Color _getEventType(String eventType){
    switch (eventType){
      case 'Deadline':
        return Colors.red;
    case 'Holiday':
      return Colors.green;
    case 'Event':
      return Colors.yellow;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: StudentCustomAppBar(title: 'Academic Calender'),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
        height: size.height,
        width: size.width,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 10),

            // Calendar table
            // Table calendar
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xfff0f0f0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TableCalendar(
                eventLoader: _getEvents,
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (BuildContext context, DateTime date, List<dynamic> events) {
                    final List<Widget> markers = [];

                    for (var event in events) {
                      print('Event: $event');
                      if (event is Map<String, dynamic> && event.containsKey('eventType')) {
                        final eventType = event['eventType'];
                        print('EventType: $eventType');
                        if (eventType == 'Deadline') {
                          markers.add(
                            Positioned(
                              bottom: 1,
                              child: Container(
                                height: 5,
                                width: 5,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          );
                        } else if (eventType == 'Holiday') {
                          markers.add(
                            Positioned(
                              bottom: 1,
                              child: Container(
                                height: 5,
                                width: 5,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          );
                        } else if (eventType == 'Event') {
                          markers.add(
                            Positioned(
                              bottom: 1,
                              child: Container(
                                height: 5,
                                width: 5,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.yellow,
                                ),
                              ),
                            ),
                          );
                        }
                      }
                    }

                    return markers.isNotEmpty ? markers.first : null;
                  },
                ),
                locale: 'en-US',
                rowHeight: 36,
                headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true),
                availableGestures: AvailableGestures.all,
                selectedDayPredicate: (day) => isSameDay(day, today),
                focusedDay: today,
                firstDay: DateTime.utc(2020, 10, 11),
                lastDay: DateTime.utc(2030, 10, 11),
                onDaySelected: _onDaySelected,
              ),


            ),

            SizedBox(height: 20),

            //sort by
            Row(
              children: [
                Text('Sort By:', style: TextStyle(color: grey_color, fontWeight: FontWeight.w500),),
                SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    color: Color(0xffd9d9d8),
                    borderRadius: BorderRadius.circular(4)
                  ),
                  child: const Row(
                    children: [
                      Text('All'),
                      Icon(Icons.keyboard_arrow_down_sharp)
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            //sorting items
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
                              String formattedDate = DateFormat('d MMMM').format(events[index].calenderDate);
                              List<String> dateParts = formattedDate.split(' ');
                              String day = dateParts[0];
                              String month = dateParts[1];
                              return Padding(
                                padding: const EdgeInsets.all(8),
                                child: InkWell(
                                  onTap: ()async{
                                  },
                                    child:  Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(4),
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                              color: orange_color,
                                            ),
                                            child: Column(
                                              children: [
                                                Text(day, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
                                                Text(month, style: TextStyle(color: Colors.white60),)
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                            width: 290,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: _getEventType(events[index].eventType),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(events[index].eventTitle.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
                                                Text(events[index].eventType.toUpperCase(), style: TextStyle(color: grey_color),),
                                              ],
                                            ),

                                          ),
                                        ],
                                      ),
                                ),
                              );
                            }
                        );
                      }
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
