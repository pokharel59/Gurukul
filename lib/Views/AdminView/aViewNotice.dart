import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gurukul_mobile_app/Components/customAppBar.dart';
import 'package:gurukul_mobile_app/Controllers/AdminController/aClassController.dart';
import 'package:gurukul_mobile_app/Controllers/AdminController/aNoticeContoller.dart';
import 'package:gurukul_mobile_app/Models/AdminModels/aNoticeModel.dart';
import 'package:gurukul_mobile_app/Views/AdminView/aAddNotice.dart';
import 'package:gurukul_mobile_app/Views/AdminView/aAddStudent.dart';

import '../../Models/AdminModels/aClassModel.dart';

class AdminViewNotice extends StatefulWidget{
  final String classId;

  AdminViewNotice({required this.classId});
  @override
  State<AdminViewNotice> createState() => _AdminViewNoticePageState();
}

class _AdminViewNoticePageState extends State<AdminViewNotice>{
  final NoticeController _noticeController = NoticeController();

  late String classId;

  void initState(){
    super.initState();
    classId = widget.classId;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(title: 'View Notices'),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminNoticePage(classId: classId),
                  ),
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
                        Text('Create Notice', style: TextStyle(color: Colors.white),),
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
                Text('View Notices', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500 ),),
              ],
            ),
          ),
          Expanded(
              child: StreamBuilder<List<NoticeModel>>(
                  stream: _noticeController.getNotice(classId),
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator());
                    }

                    if(snapshot.hasError){
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    List<NoticeModel> notices = snapshot.data ?? [];

                    if(notices.isEmpty){
                      return Center(child: Text('No notices available.'));
                    }

                    return ListView.builder(
                        itemCount: notices.length,
                        itemBuilder: (context, index){
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: InkWell(
                              onTap: (){
                              },
                              child: Card(
                                child: ListTile(
                                  title: Text(notices[index].title),
                                  subtitle: Text(notices[index].description),
                                ),
                              ),
                            ),
                          );
                        }
                    );
                  }
              )
          )
        ],
      ),
    );
  }

}