import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    // variables declaration
    var primary_color = Color(0xFFD000B6);
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
                  IconButton(onPressed: (){ Navigator.pushReplacementNamed(context, '/login');}, icon: Icon(Icons.menu),alignment: Alignment.centerLeft,),
                  Text('Home', style: TextStyle(fontSize: 20),),
                  IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none),alignment: Alignment.centerRight,),
                ],
              ),

              // horizontal separator
              Container(
                height: 2,
                width: size.width,
                color: Colors.grey,
              ),

            // notice board
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 4),
              child: SizedBox(
                width: double.infinity,
                child: Text('Notice Board', textAlign: TextAlign.start, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: primary_color),)),
            ),

            SizedBox(height: 10),

            // single child scrollview
            SingleChildScrollView(
              padding: EdgeInsets.only(left: 20),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 180,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Color(0xffa1e9ff),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network('https://images.unsplash.com/photo-1517694712202-14dd9538aa97?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                            width: 80,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('Hackathon program \nfrom the 29 Jan to 3 Feb'),
                        SizedBox(height: 30),
                        Text('27 January 2024', style: TextStyle(fontSize: 10, color: Colors.grey.shade600),),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 180,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Color(0xffa8df8e),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network('https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                            width: 80,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('Welcome Program \non 5 Feb'),
                        SizedBox(height: 46),
                        Text('02 February 2024', style: TextStyle(fontSize: 10, color: Colors.grey.shade600),),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 180,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Color(0xfffebebf),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network('https://images.unsplash.com/photo-1537884557178-342a575d7d16?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                            width: 80,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('Drawing Competition \nfrom the 28 Feb to 2 Mar'),
                        SizedBox(height: 14),
                        Text('27 February 2024', style: TextStyle(fontSize: 10, color: Colors.grey.shade600),),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 180,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Color(0xffff6ca7),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network('https://images.unsplash.com/photo-1452626038306-9aae5e071dd3?q=80&w=2074&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                            width: 80,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('College Marathon \non 17 May'),
                        SizedBox(height: 46),
                        Text('23 February 2024', style: TextStyle(fontSize: 10, color: Colors.grey.shade600),),
                      ],
                    ),
                  ),
                ],
              ),
              ),

            // events
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
              child: SizedBox(
                  width: double.infinity,
                  child: Text('Events', textAlign: TextAlign.start, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: primary_color),)),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: primary_color
              ),
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network('https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                            width: 80,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 6),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Welcome Program \non 5 Feb,',style: TextStyle(color:Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
                            Text('02 February 2024', style: TextStyle(color: Colors.white70,),)
                          ],
                        ),
                        SizedBox(width: 2),
                        Container(
                          width: 60,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)
                            ),
                          child: Center(child: Text('Details',style: TextStyle(color: Color(0xff3A3A3A)),)),
                        )
                      ],
                    ),
                  ),

                  // 3 dots
                  Positioned(
                    bottom: 6,
                    left: 160,
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),
            Container(
              height: 2,
              width: size.width - 40,
              color: Colors.grey.shade400,
            ),

            // assignments
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
              child: SizedBox(
                  width: double.infinity,
                  child: Text('Assignments', textAlign: TextAlign.start, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: primary_color),)),
            ),

            // assignments items
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(left: 20, right: 20),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Color(0xfffad8d6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.radio_button_off_outlined, color: Colors.grey,)),
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
                    SizedBox(height: 10),
                    Container(
                      height: 60,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Color(0xfffad8d6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.check_circle_rounded, color: primary_color,)),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Learn chapter 5 with one Essay'),
                                SizedBox(height: 6),
                                Text('Computer Science / Today',style: TextStyle(fontSize: 12,color: Colors.grey.shade600)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 60,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Color(0xfffad8d6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.check_circle_rounded, color: primary_color,)),
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
                    SizedBox(height: 10),
                    Container(
                      height: 60,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Color(0xfffad8d6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.check_circle_rounded, color: primary_color,)),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Learn chapter 5 with one Essay'),
                                SizedBox(height: 6),
                                Text('Arts / Today',style: TextStyle(fontSize: 12,color: Colors.grey.shade600)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 60,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Color(0xfffad8d6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.check_circle_rounded, color: primary_color,)),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Learn chapter 5 with one Essay'),
                                SizedBox(height: 6),
                                Text('Sports / Today',style: TextStyle(fontSize: 12,color: Colors.grey.shade600)),
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






