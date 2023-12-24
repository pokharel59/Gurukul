import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  var orange_color = Color(0xfff04d22);
  var primary_color = Color(0xffbe00fe);
  var grey_color = Colors.grey;
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
                IconButton(onPressed: (){ Navigator.pushReplacementNamed(context, '/login');}, icon: Icon(Icons.menu),alignment: Alignment.centerLeft,),
                Text('Events', style: TextStyle(fontSize: 20),),
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

            //upcoming events
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Upcoming Events', textAlign: TextAlign.start, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: primary_color),),
                Container(
                  padding: EdgeInsets.only(left: 6),
                  width: 36,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Color(0xFFea1e63),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.favorite,color:Colors.white,size: 16,),
                      SizedBox(width: 1,),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text('1',style: TextStyle(color: Colors.white,fontSize: 12),),
                      )
                    ],
                  ),
                )
              ],
            ),

            SizedBox(height: 10),

            //single child scrollview
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 180,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Color(0xff697efe),
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
                        SizedBox(height: 16),
                        Text('Welcome \nProgram',style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 12,color: Colors.white60,),
                            Text('PCPS College', style: TextStyle(color: Colors.white60,fontSize: 12),),
                          ],
                        ),
                        SizedBox(height: 10),
                        //stack container
                        Container(
                          width: size.width,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 9,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 8,
                                  backgroundImage: Image.network('https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                ),
                              ),
                              Positioned(
                                left: 10,
                                child: CircleAvatar(
                                  radius: 9,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                  radius: 8,
                                  backgroundImage: Image.network('https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?q=80&w=2048&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                ),

                              )),
                              Positioned(
                                  left: 20,
                                  child: CircleAvatar(
                                    radius: 9,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 8,
                                      backgroundImage: Image.network('https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                    ),

                                  )),
                              Positioned(
                                  left: 30,
                                  child: CircleAvatar(
                                    radius: 9,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 8,
                                      backgroundImage: Image.network('https://plus.unsplash.com/premium_photo-1670282393309-70fd7f8eb1ef?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                    ),

                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 180,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Color(0xFF398e3d),
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
                        SizedBox(height: 16),
                        Text('Welcome \nProgram',style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 12,color: Colors.white60,),
                            Text('PCPS College', style: TextStyle(color: Colors.white60,fontSize: 12),),
                          ],
                        ),
                        SizedBox(height: 10),
                        //stack container
                        Container(
                          width: size.width,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 9,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 8,
                                  backgroundImage: Image.network('https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                ),
                              ),
                              Positioned(
                                  left: 10,
                                  child: CircleAvatar(
                                    radius: 9,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 8,
                                      backgroundImage: Image.network('https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?q=80&w=2048&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                    ),

                                  )),
                              Positioned(
                                  left: 20,
                                  child: CircleAvatar(
                                    radius: 9,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 8,
                                      backgroundImage: Image.network('https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                    ),

                                  )),
                              Positioned(
                                  left: 30,
                                  child: CircleAvatar(
                                    radius: 9,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 8,
                                      backgroundImage: Image.network('https://plus.unsplash.com/premium_photo-1670282393309-70fd7f8eb1ef?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                    ),

                                  )),
                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 180,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Color(0xFFea1e63),
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
                        SizedBox(height: 16),
                        Text('Welcome \nProgram',style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 12,color: Colors.white60,),
                            Text('PCPS College', style: TextStyle(color: Colors.white60,fontSize: 12),),
                          ],
                        ),
                        SizedBox(height: 10),
                        //stack container
                        Container(
                          width: size.width,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 9,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 8,
                                  backgroundImage: Image.network('https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                ),
                              ),
                              Positioned(
                                  left: 10,
                                  child: CircleAvatar(
                                    radius: 9,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 8,
                                      backgroundImage: Image.network('https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?q=80&w=2048&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                    ),

                                  )),
                              Positioned(
                                  left: 20,
                                  child: CircleAvatar(
                                    radius: 9,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 8,
                                      backgroundImage: Image.network('https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                    ),

                                  )),
                              Positioned(
                                  left: 30,
                                  child: CircleAvatar(
                                    radius: 9,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 8,
                                      backgroundImage: Image.network('https://plus.unsplash.com/premium_photo-1670282393309-70fd7f8eb1ef?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                    ),

                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 180,
                    width: 120,
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
                          child: Image.network('https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                            width: 80,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text('Welcome \nProgram',style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 12,color: Colors.white60,),
                            Text('PCPS College', style: TextStyle(color: Colors.white60,fontSize: 12),),
                          ],
                        ),
                        SizedBox(height: 10),
                        //stack container
                        Container(
                          width: size.width,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 9,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 8,
                                  backgroundImage: Image.network('https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                ),
                              ),
                              Positioned(
                                  left: 10,
                                  child: CircleAvatar(
                                    radius: 9,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 8,
                                      backgroundImage: Image.network('https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?q=80&w=2048&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                    ),

                                  )),
                              Positioned(
                                  left: 20,
                                  child: CircleAvatar(
                                    radius: 9,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 8,
                                      backgroundImage: Image.network('https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                    ),

                                  )),
                              Positioned(
                                  left: 30,
                                  child: CircleAvatar(
                                    radius: 9,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 8,
                                      backgroundImage: Image.network('https://plus.unsplash.com/premium_photo-1670282393309-70fd7f8eb1ef?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                    ),

                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 22),

            //running events
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Running Events', textAlign: TextAlign.start, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: primary_color),),
                Container(
                  padding: EdgeInsets.only(left: 6),
                  width: 36,
                  height: 20,
                  decoration: BoxDecoration(
                      color: Color(0xFF687dfb),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.thumb_up,color:Colors.white,size: 16,),
                      SizedBox(width: 2,),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text('2',style: TextStyle(color: Colors.white,fontSize: 12),),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 180,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Color(0xFF398e3d),
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

                        Text('Welcome \nProgram',style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 10,color: Colors.white60,),
                            Text('PCPS College', style: TextStyle(color: Colors.white60,fontSize: 10),),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.thumb_up, size: 16,color: Colors.white,),
                            Container(
                              width: 60,
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 9,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 8,
                                      backgroundImage: Image.network('https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                    ),
                                  ),
                                  Positioned(
                                      left: 10,
                                      child: CircleAvatar(
                                        radius: 9,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: 8,
                                          backgroundImage: Image.network('https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?q=80&w=2048&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                        ),

                                      )),
                                  Positioned(
                                      left: 20,
                                      child: CircleAvatar(
                                        radius: 9,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: 8,
                                          backgroundImage: Image.network('https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                        ),

                                      )),
                                  Positioned(
                                      left: 30,
                                      child: CircleAvatar(
                                        radius: 9,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: 8,
                                          backgroundImage: Image.network('https://plus.unsplash.com/premium_photo-1670282393309-70fd7f8eb1ef?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                        ),
                                      ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
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
                      color: Color(0xff697efe),
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

                        Text('Welcome \nProgram',style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 10,color: Colors.white60,),
                            Text('PCPS College', style: TextStyle(color: Colors.white60,fontSize: 10),),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.thumb_up, size: 16,color: Color(0xff697efe),),
                            Container(
                              width: 60,
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 9,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 8,
                                      backgroundImage: Image.network('https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                    ),
                                  ),
                                  Positioned(
                                      left: 10,
                                      child: CircleAvatar(
                                        radius: 9,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: 8,
                                          backgroundImage: Image.network('https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?q=80&w=2048&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                        ),
                                      ),
                                  ),
                                  Positioned(
                                      left: 20,
                                      child: CircleAvatar(
                                        radius: 9,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: 8,
                                          backgroundImage: Image.network('https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                        ),

                                      )),
                                  Positioned(
                                    left: 30,
                                    child: CircleAvatar(
                                      radius: 9,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 8,
                                        backgroundImage: Image.network('https://plus.unsplash.com/premium_photo-1670282393309-70fd7f8eb1ef?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
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
                      color: Color(0xFFea1e63),
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

                        Text('Welcome \nProgram',style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 10,color: Colors.white60,),
                            Text('PCPS College', style: TextStyle(color: Colors.white60,fontSize: 10),),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.thumb_up, size: 16,color: Colors.blueAccent,),
                            Container(
                              width: 60,
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 9,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 8,
                                      backgroundImage: Image.network('https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                    ),
                                  ),
                                  Positioned(
                                      left: 10,
                                      child: CircleAvatar(
                                        radius: 9,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: 8,
                                          backgroundImage: Image.network('https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?q=80&w=2048&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                        ),

                                      )),
                                  Positioned(
                                      left: 20,
                                      child: CircleAvatar(
                                        radius: 9,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: 8,
                                          backgroundImage: Image.network('https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                        ),

                                      )),
                                  Positioned(
                                      left: 30,
                                      child: CircleAvatar(
                                        radius: 9,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: 8,
                                          backgroundImage: Image.network('https://plus.unsplash.com/premium_photo-1670282393309-70fd7f8eb1ef?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                        ),

                                      )),
                                ],
                              ),
                            )
                          ],
                        ),
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
                          child: Image.network('https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                            width: 80,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 10),

                        Text('Welcome \nProgram',style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 10,color: Colors.white60,),
                            Text('PCPS College', style: TextStyle(color: Colors.white60,fontSize: 10),),
                          ],
                        ),
                        SizedBox(height: 16,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.thumb_up, size: 16,color: Colors.white60,),
                            Container(
                              width: 60,
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 9,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 8,
                                      backgroundImage: Image.network('https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                    ),
                                  ),
                                  Positioned(
                                      left: 10,
                                      child: CircleAvatar(
                                        radius: 9,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: 8,
                                          backgroundImage: Image.network('https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?q=80&w=2048&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                        ),

                                      )),
                                  Positioned(
                                      left: 20,
                                      child: CircleAvatar(
                                        radius: 9,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: 8,
                                          backgroundImage: Image.network('https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                        ),

                                      )),
                                  Positioned(
                                      left: 30,
                                      child: CircleAvatar(
                                        radius: 9,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: 8,
                                          backgroundImage: Image.network('https://plus.unsplash.com/premium_photo-1670282393309-70fd7f8eb1ef?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                                        ),

                                      )),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),

            //your participation
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Your participation', textAlign: TextAlign.start, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: primary_color),),
              ],
            ),
            SizedBox(height: 10,),
            //bottom containers
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 2, 20, 0),
                      height: 70,
                      decoration: BoxDecoration(
                        color: Color(0xff697efe),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network('https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                  width: 70,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 14),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 8,),
                                  Text('Welcome Program', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
                                  Text('12 Dec 2024', style: TextStyle(color: Colors.white,fontSize: 12),),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on, size: 12,color: Colors.white,),
                                      Text('PCPS College', style: TextStyle(color: Colors.white,fontSize: 12),),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          Container(
                            width: 90,
                            height: 26,
                            decoration: BoxDecoration(
                              color: Color(0xFF37c92c),
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Center(child: Text('Running', style: TextStyle(color: Colors.white),)),
                          )

                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 2, 10, 0),
                      height: 70,
                      decoration: BoxDecoration(
                          color: Color(0xFFea1e63),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network('https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                  width: 70,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 14),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 8,),
                                  Text('Welcome Program', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
                                  Text('12 Dec 2024', style: TextStyle(color: Colors.white,fontSize: 12),),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on, size: 12,color: Colors.white,),
                                      Text('PCPS College', style: TextStyle(color: Colors.white,fontSize: 12),),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          Container(
                            width: 90,
                            height: 26,
                            decoration: BoxDecoration(
                                color: Color(0xFFfdd503),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Center(child: Text('Upcoming', style: TextStyle(color: Colors.white),)),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 4),
                            width: 50,
                            height: 26,
                            decoration: BoxDecoration(
                                color: Color(0xFFca2b2b),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  Center(child: Text('Drop', style: TextStyle(color: Colors.white),)),
                                  SizedBox(width: 2,),
                                  Icon(Icons.logout,size: 12,color: Colors.white,)
                                ],
                              ),
                            ),
                          )


                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 2, 20, 0),
                      height: 70,
                      decoration: BoxDecoration(
                          color: Color(0xff697efe),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network('https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                  width: 70,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 14),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 8,),
                                  Text('Welcome Program', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
                                  Text('12 Dec 2024', style: TextStyle(color: Colors.white,fontSize: 12),),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on, size: 12,color: Colors.white,),
                                      Text('PCPS College', style: TextStyle(color: Colors.white,fontSize: 12),),
                                    ],
                                  )
                                ],
                              ),
                            ],
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
