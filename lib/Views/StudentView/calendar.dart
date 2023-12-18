import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  var orange_color = Color(0xfff04d22);
  var primary_color = Color(0xffbe00fe);
  var grey_color = Colors.grey;

  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focus) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
        height: size.height,
        width: size.width,
        color: Colors.white,
        child: Column(
          children: [
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.chevron_left),alignment: Alignment.centerLeft,),
                  Text('Calendar', style: TextStyle(fontSize: 20),),
                  IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none),alignment: Alignment.centerRight,),
                ],
              ),

            //horizontal separator
            Container(
              height: 2,
              width: size.width,
              color: Colors.grey,
            ),

            SizedBox(height: 10),

            //calendar table
            //table calendar
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xfff0f0f0),
                borderRadius: BorderRadius.circular(10)
              ),
              child: TableCalendar(
                locale: 'en-US',
                rowHeight: 36,
                headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true),
                availableGestures: AvailableGestures.all,
                selectedDayPredicate: (day) => isSameDay(day, today),

                focusedDay: today,
                firstDay: DateTime.utc(2020, 10, 11),
                lastDay: DateTime.utc(2030, 10, 11 ),
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
                  child: Row(
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
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: orange_color,
                            ),
                            child: Column(
                              children: [
                                Text('03', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
                                Text('Jan', style: TextStyle(color: Colors.white60),)
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            width: 290,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffa1e9ff),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('National Holiday', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                                Text('Holiday', style: TextStyle(color: grey_color),)
                              ],
                            ),

                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: orange_color,
                            ),
                            child: Column(
                              children: [
                                Text('05', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
                                Text('Feb', style: TextStyle(color: Colors.white60),)
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            width: 290,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xfffad8d6),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Welcome Program', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                                Text('Events', style: TextStyle(color: grey_color),)
                              ],
                            ),

                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: orange_color,
                            ),
                            child: Column(
                              children: [
                                Text('14', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
                                Text('Mar', style: TextStyle(color: Colors.white60),)
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            width: 290,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffa8df8e),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('CIS099-2 Assignment 1', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                                Text('Deadlines', style: TextStyle(color: grey_color),)
                              ],
                            ),

                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: orange_color,
                            ),
                            child: Column(
                              children: [
                                Text('23', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
                                Text('May', style: TextStyle(color: Colors.white60),)
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            width: 290,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffFF8A65),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Dashain Holiday', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                                Text('Holiday', style: TextStyle(color: grey_color),)
                              ],
                            ),

                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: orange_color,
                            ),
                            child: Column(
                              children: [
                                Text('07', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
                                Text('June', style: TextStyle(color: Colors.white60),)
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            width: 290,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xff9FA8DA),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('College Marathon', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                                Text('Sports', style: TextStyle(color: grey_color),)
                              ],
                            ),

                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: orange_color,
                            ),
                            child: Column(
                              children: [
                                Text('11', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
                                Text('Jun', style: TextStyle(color: Colors.white60),)
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            width: 290,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffFFB300),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Assignment 2', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                                Text('Exam', style: TextStyle(color: grey_color),)
                              ],
                            ),

                          ),
                        ],
                      ),SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: orange_color,
                            ),
                            child: Column(
                              children: [
                                Text('17', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
                                Text('Jun', style: TextStyle(color: Colors.white60),)
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            width: 290,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xff8BC34A),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Viva', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                                Text('Exam', style: TextStyle(color: grey_color),)
                              ],
                            ),

                          ),
                        ],
                      ),SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: orange_color,
                            ),
                            child: Column(
                              children: [
                                Text('21', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
                                Text('Jun', style: TextStyle(color: Colors.white60),)
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            width: 290,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffB0BEC5),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Music Festival', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                                Text('Events', style: TextStyle(color: grey_color),)
                              ],
                            ),

                          ),
                        ],
                      ),SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: orange_color,
                            ),
                            child: Column(
                              children: [
                                Text('27', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
                                Text('Jun', style: TextStyle(color: Colors.white60),)
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            width: 290,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffF06292),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Semester End', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                                Text('', style: TextStyle(color: grey_color),)
                              ],
                            ),

                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
