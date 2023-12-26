import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gurukul_mobile_app/Components/customAppBar.dart';

class AdminNoticePage extends StatefulWidget{
  const AdminNoticePage({super.key});

  @override
  State<AdminNoticePage> createState() => _AdminNoticePageState();
}

class _AdminNoticePageState extends State<AdminNoticePage>{
  Future<void> getFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
}
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(title: 'Add Notice'),
      body: Padding(
        padding: const EdgeInsets.only(top: 25.0, right: 14.0, left: 14.0),
        child: Column(
          children: [
            const Row(
              children: [
                Text('Notice Title', style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500),),
              ],
            ),
            const SizedBox(height: 10),
            const SizedBox(
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF808080))
                  ),
                  hintText: 'Enter Title',
                  hintStyle: TextStyle(color: Color(0xFF808080))
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            const Row(
              children: [
                Text('Notice Description', style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500),),
              ],
            ),
            const SizedBox(height: 10),
            const SizedBox(
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF808080))
                    ),
                    hintText: 'Enter Description',
                    hintStyle: TextStyle(color: Color(0xFF808080))
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                GestureDetector(
                  onTap: (){
                    getFiles();
                  },
                  child: Container(
                    width: 500,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: Column(
                          children: [
                              Icon(Icons.upload_file, color: Colors.black),
                            Text('Upload Files/Image'),
                          ],
                        ),
                      ),
                  ),
                ),
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
                            onPressed: (){

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
                    const Column(
                      children: [
                        Row(
                          children: [
                            Text('View Notices', style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500),),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
                          child: SizedBox(
                            height: 70,
                            width: 360,
                            child: Card(
                              child: ListTile(
                                leading: Text('Welcome'),
                              ),
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