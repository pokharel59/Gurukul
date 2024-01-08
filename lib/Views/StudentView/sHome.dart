import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gurukul_mobile_app/Components/studentCustomAppBar.dart';
import 'package:gurukul_mobile_app/Views/StudentView/sAssignment.dart';
import 'package:gurukul_mobile_app/Views/StudentView/sNotice.dart';
import '../../Controllers/AdminController/aAssignmentController.dart';
import '../../Controllers/AdminController/aNoticeContoller.dart';
import '../../Models/AdminModels/aAssignmentModel.dart';
import '../../Models/AdminModels/aNoticeModel.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomePage extends StatefulWidget {
  final String classId;
  final String studentName;
  final String studentID;

  HomePage({required this.classId, required this.studentName, required this.studentID});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NoticeController _noticeController = NoticeController();
  final AssignmentController assignmentController = AssignmentController();
  var primary_color = Color(0xFF687EFF);
  final Random random = Random();
  late String classId;
  late String studentName;
  late String studentID;

  void initState() {
    super.initState();
    classId = widget.classId;
    studentName = widget.studentName;
    studentID = widget.studentID;
  }

  Future<void> refresh() async {
    setState(() {});
  }

  final List<Color> predefinedColors = [
    Color(0xFFA8DF8E),
    Color(0xFFA0E9FF),
    Color(0xFFffbfbf),
    Color(0xFFFEFFAC),
    Color(0xFFFFB6D9),
  ];

  Color _getRandomColor(){
    return predefinedColors[random.nextInt(predefinedColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: StudentCustomAppBar(title:'Home', studentId: studentID, studentName: studentName,),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
        height: size.height,
        width: size.width,
        color: Colors.white,
        child: Column(
          children: [
            // Notice board
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 10, 4),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  'Notice Board',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color:primary_color),
                ),
              ),
            ),

            SizedBox(height: 10),

            // Refresh Indicator and StreamBuilder for Notices
              RefreshIndicator(
                onRefresh: refresh,
                child: StreamBuilder<List<NoticeModel>>(
                  stream: _noticeController.getNotice(classId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: LoadingAnimationWidget.inkDrop(color:primary_color, size: 37)
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    List<NoticeModel> notices = snapshot.data ?? [];

                    if (notices.isEmpty) {
                      return Center(child: Text('No notices available.'));
                    }

                    return Container(
                      height: 200, // Adjust the height as needed
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: notices.length,
                        itemBuilder: (BuildContext context, int index) {
                          Color cardColor = _getRandomColor();
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              height: 200,
                              width: 175,
                              margin: EdgeInsets.only(right: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: cardColor
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      notices[index].documentUrl,
                                      width: 80,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(notices[index].title),
                                  SizedBox(height: 30),
                                  Text(
                                    '27 January 2024',
                                    style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            // Events
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 5, 10),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  'Events',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: primary_color),
                ),
              ),
            ),

            // Event Container
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: primary_color,
              ),
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                            width: 80,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 6),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome Program \non 5 Feb,',
                              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '02 February 2024',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                        SizedBox(width: 2),
                        Container(
                          width: 60,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(child: Text('Details', style: TextStyle(color: Color(0xff3A3A3A)))),
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

            // Assignments
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  'Assignments',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: primary_color),
                ),
              ),
            ),

            SizedBox(height: 10),
// Assignments Items
            Expanded(
                child: RefreshIndicator(
                  onRefresh: refresh,
                  child: StreamBuilder<List<AssignmentModel>>(
                    stream: assignmentController.getAssignment(classId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: LoadingAnimationWidget.inkDrop(color:primary_color, size: 37));
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      List<AssignmentModel> assignments = snapshot.data ?? [];
                      print(assignments);

                      if (assignments.isEmpty) {
                        return Center(child: Text('No assignments available.'));
                      }

                      return ListView.builder(
                        itemCount: assignments.length,
                        itemBuilder: (context, index) {
                          String assignmentSubject = assignments[index].subject;
                          DateTime assignmentDate = assignments[index].deadline;

                          List<Map<String, dynamic>> checkAssignmentSubmitted = assignments[index].studentsSubmittion;
                          bool isAssignmentSubmitted = checkAssignmentSubmitted.any(
                                (assignmentSubmit) =>
                            assignmentSubmit.containsValue(studentName) &&
                                assignmentSubmit.containsValue(studentID),
                          );

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Container(
                              height: 60,
                              width: size.width,
                              decoration: BoxDecoration(
                                color: Color(0xfffad8d6),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: isAssignmentSubmitted
                                        ? Icon(Icons.check_circle_rounded, color: primary_color)
                                        : Icon(Icons.circle_outlined, color: Colors.grey.shade600),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(assignments[index].title),
                                        SizedBox(height: 6),
                                        Text('$assignmentSubject / $assignmentDate', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
