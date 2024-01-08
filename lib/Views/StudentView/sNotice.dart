import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gurukul_mobile_app/Components/studentCustomAppBar.dart';
import 'package:gurukul_mobile_app/Controllers/AdminController/aNoticeContoller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'dart:math';
import '../../Models/AdminModels/aNoticeModel.dart';

class NoticePage extends StatefulWidget{
  final String classId;
  final String studentName;
  final String studentID;

  NoticePage({required this.classId, required this.studentName, required this.studentID});
  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage>{
  final NoticeController _noticeController = NoticeController();
  var primary_color = Color(0xFF687EFF);
  final Random random = Random();
  late String classId;
  late String studentName;
  late String studentID;

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

  void initState(){
    super.initState();
    classId = widget.classId;
    studentName = widget.studentName;
    studentID = widget.studentID;
  }

  Future<void> refresh()async{
    setState(() {

    });
  }

  void noticeDetail(String fileUrl, String title, String description){
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20)
            )
        ),
        builder: (BuildContext cotext){
          return Container(
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Image.network(fileUrl),
                ),
                Text(title),
                Text(description)
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
      appBar: StudentCustomAppBar(title: "Notice Board", studentId: studentID, studentName: studentName,),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Expanded(
              child: RefreshIndicator(
                onRefresh: refresh,
                child: StreamBuilder<List<NoticeModel>>(
                    stream: _noticeController.getNotice(classId),
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(child: LoadingAnimationWidget.inkDrop(color:primary_color, size: 37));
                      }

                      if(snapshot.hasError){
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      List<NoticeModel> notices = snapshot.data ?? [];

                      if(notices.isEmpty){
                        return Center(child: Text('No notices available.'));
                      }

                      return GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of items in a row
                          crossAxisSpacing: 8.0, // Spacing between items horizontally
                          mainAxisSpacing: 8.0, // Spacing between items vertically
                        ),
                        itemCount: notices.length,
                        itemBuilder: (BuildContext context, int index) {
                          Color cardColor = _getRandomColor();
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (){
                                noticeDetail(
                                    notices[index].documentUrl,
                                    notices[index].title,
                                    notices[index].description
                                );
                              },
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      height: 200,
                                      width: 175,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: cardColor
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.network (notices[index].documentUrl,
                                              width: 80,
                                              height: 60,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(notices[index].title),
                                          SizedBox(height: 30),
                                          Text('27 January 2024', style: TextStyle(fontSize: 10, color: Colors.grey.shade600),),
                                        ],
                                      ),
                                    ),
                                    //Text(DateTime.now().toString())
                                  ],
                                ),
                            ),
                          );
                        },
                      );

                    }
                ),
              )
          )
        ]
      )
    );
  }

}

