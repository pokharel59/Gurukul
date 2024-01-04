import 'package:flutter/material.dart';
import 'package:gurukul_mobile_app/Components/messageToast.dart';
import 'package:gurukul_mobile_app/Models/AdminModels/aStudentModel.dart';
import 'package:gurukul_mobile_app/Models/AdminModels/aTeacherModel.dart';
import 'package:gurukul_mobile_app/Views/StudentView/sAssignment.dart';
import 'package:gurukul_mobile_app/Views/StudentView/sHome.dart';
import 'package:gurukul_mobile_app/loginController.dart';
import 'package:gurukul_mobile_app/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController ClassName = TextEditingController();
  TextEditingController StudentIDText = TextEditingController();
  TextEditingController PasswordText = TextEditingController();
  LoginController loginController = LoginController();
  Toaster showMessage = Toaster();

  @override
  Widget build(BuildContext context) {
    //var height =  MediaQuery.sizeOf(context).height;
    //var width =  MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Color(0xFFF2F2F2),
          ),
          Positioned(
            top: -320,
            left: 0,
            child: Container(
              padding: EdgeInsets.only(top: 160),
              child: Container(
                padding: EdgeInsets.only(top: 200),
                child: Image(
                  image: ResizeImage(
                      AssetImage('assets/gurukul-logo.png'),
                      width: 240,
                      height: 240),
                ),
              ),
              height: 600,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFA4C4E0),
                    Color(0xFFA4C4E0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            child: Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
              height: 500,
              width: MediaQuery.sizeOf(context).width - 30,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(36),
                boxShadow:  [
                  BoxShadow(
                    color: Color(0xffcccccc),
                    offset: Offset(1, 4),
                    blurRadius: 20,
                  ),
                ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text("Login",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text("Class Name",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  //student id text input
                  SizedBox(
                    height: 50,
                    child: TextField(
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      controller: ClassName,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter class name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabled: true,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  //student id text
                  Text("Student ID",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  //student id text input
                  SizedBox(
                    height: 50,
                    child: TextField(
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      controller: StudentIDText,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: '2210222027',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabled: true,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  //password text
                  Text("Password",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  //password input
                  SizedBox(
                    height: 50,
                    child: TextField(
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      controller: PasswordText,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: '*********',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabled: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 2),

                  //forgot password text
                  Container(
                    width: double.infinity,
                    child: Text("Forgot Password?",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(0xffafafaf),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  //login button
                  ElevatedButton(
                    onPressed: ()async {
                      String enteredID = StudentIDText.text.trim();
                      String enteredPassword = PasswordText.text.trim();
                      String enteredClassName = ClassName.text;

                      if (enteredID == null || enteredID.isEmpty || enteredPassword == null || enteredPassword.isEmpty) {
                        showMessage.showToast('Field cannot be empty');
                      } else {
                        String? documentID = await loginController.getDocumentIDByClassName(enteredClassName);

                        if(documentID != null){
                          List<StudentModel> students = await loginController.fetchStudentData(documentID);
                          List<TeacherModel> teachers = await loginController.fetchSTeacherData(documentID);

                          if(students.any((student) => student.id == enteredID && student.password == enteredPassword)){
                            Navigator.push(context, 
                                MaterialPageRoute(builder: (context) => MyHomePage(classId: documentID, studentID: students.first.id, studentName: students.first.name,))
                            );
                            showMessage.showToast('Login successful');
                          }if(teachers.any((teacher) => teacher.id == enteredID && teacher.password == enteredPassword)){
                            Navigator.pushReplacementNamed(context, '/adminPage');
                            showMessage.showToast('Login successful');
                          }else{
                            showMessage.showToast('Error login');
                          }

                        }else{
                          showMessage.showToast('Document ID did not found');
                        }
                      }
                    },

                    child: SizedBox(
                      height: 50,
                      width: double.infinity,//
                      child: Center(
                        child: Text("Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(  //.styleForm style the elevated button.
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Color(0xFF687EFF),
                    ),
                  ),
                ],
            ),
          ),
          ),
        ],
      ),
    );
  }
}
