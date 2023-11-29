import 'package:flutter/material.dart';

class AssignmentPage extends StatefulWidget {
  const AssignmentPage({super.key});

  @override
  State<AssignmentPage> createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  var orange_color = Color(0xfff04d22);
  var primary_color = Color(0xffbe00fe);
  var grey_color = Colors.grey;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      //bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: primary_color,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month),label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment),label: 'Assignment'),
          BottomNavigationBarItem(icon: Icon(Icons.event),label: 'Events'),
        ],
      ),
      
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
        height: size.height,
        width: size.width,
        color: Colors.white,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: (){}, icon: Icon(Icons.chevron_left),alignment: Alignment.centerLeft,),
                Text('Assignment', style: TextStyle(fontSize: 20),),
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
            
            //main contents
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //today
                    Text('Today', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: primary_color),),
                    SizedBox(height: 20),

                    //today row items
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color(0xfffad8d6),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.radio_button_off, color: Colors.grey,)),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Learn chapter 5 with one Essay'),
                                SizedBox(height: 6),
                                Text('English / Today',style: TextStyle(fontSize: 12,color: Colors.grey.shade600)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color(0xfffad8d6),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.circle, color: primary_color,)),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Learn chapter 7 with one Essay'),
                                SizedBox(height: 6),
                                Text('Computer Science / Today',style: TextStyle(fontSize: 12,color: Colors.grey.shade600)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color(0xfffad8d6),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.circle, color: primary_color,)),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Learn chapter 5 with one Essay'),
                                SizedBox(height: 6),
                                Text('English / Today',style: TextStyle(fontSize: 12,color: Colors.grey.shade600)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    //yesterday
                    Text('Yesterday', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: primary_color),),
                    SizedBox(height: 20),

                    //yesterday row items
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color(0xfffad8d6),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.radio_button_off, color: Colors.grey,)),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Learn chapter 5 with one Essay'),
                                SizedBox(height: 6),
                                Text('Literature / Today',style: TextStyle(fontSize: 12,color: Colors.grey.shade600)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color(0xfffad8d6),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.circle, color: primary_color,)),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Learn chapter 5 with one Essay'),
                                SizedBox(height: 6),
                                Text('English / Today',style: TextStyle(fontSize: 12,color: Colors.grey.shade600)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    //15 feb text
                    Text('15 Feb 2024', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: primary_color),),
                    SizedBox(height: 20),

                    //15 Feb row items
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color(0xfffad8d6),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.circle, color: primary_color,)),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Learn chapter 5 with one Essay'),
                                SizedBox(height: 6),
                                Text('English / Today',style: TextStyle(fontSize: 12,color: Colors.grey.shade600)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color(0xfffad8d6),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.circle, color: primary_color,)),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Learn chapter 5 with one Essay'),
                                SizedBox(height: 6),
                                Text('English / Today',style: TextStyle(fontSize: 12,color: Colors.grey.shade600)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14),

                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color(0xfffad8d6),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.circle, color: primary_color,)),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Learn chapter 5 with one Essay'),
                                SizedBox(height: 6),
                                Text('English / Today',style: TextStyle(fontSize: 12,color: Colors.grey.shade600)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color(0xfffad8d6),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.circle, color: primary_color,)),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Learn chapter 5 with one Essay'),
                                SizedBox(height: 6),
                                Text('English / Today',style: TextStyle(fontSize: 12,color: Colors.grey.shade600)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color(0xfffad8d6),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.circle, color: primary_color,)),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Learn chapter 5 with one Essay'),
                                SizedBox(height: 6),
                                Text('English / Today',style: TextStyle(fontSize: 12,color: Colors.grey.shade600)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color(0xfffad8d6),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.circle, color: primary_color,)),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Learn chapter 5 with one Essay'),
                                SizedBox(height: 6),
                                Text('English / Today',style: TextStyle(fontSize: 12,color: Colors.grey.shade600)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color(0xfffad8d6),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.circle, color: primary_color,)),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Learn chapter 5 with one Essay'),
                                SizedBox(height: 6),
                                Text('English / Today',style: TextStyle(fontSize: 12,color: Colors.grey.shade600)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color(0xfffad8d6),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.circle, color: primary_color,)),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Learn chapter 5 with one Essay'),
                                SizedBox(height: 6),
                                Text('English / Today',style: TextStyle(fontSize: 12,color: Colors.grey.shade600)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color(0xfffad8d6),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.circle, color: primary_color,)),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Learn chapter 5 with one Essay'),
                                SizedBox(height: 6),
                                Text('English / Today',style: TextStyle(fontSize: 12,color: Colors.grey.shade600)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
