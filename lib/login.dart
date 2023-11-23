import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    //var height =  MediaQuery.sizeOf(context).height;
    //var width =  MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color(0xFFF2F2F2),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.only(top: 70),
              child: Container(
                child: Image(
                  image: ResizeImage(
                      AssetImage(
                          'assets/gurukul-logo.png'
                      ),
                      width: 250 ,
                      height: 250),
                ),
              ),
              height: 250,
              width: MediaQuery.sizeOf(context).width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFD000B6),
                    Color(0x20EC00B4),
                  ],
                ),
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(110),
                )
              ),

            ),
          ),
          Positioned(
            bottom: 100,
            child: Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
              height: 450,
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
                  //student id text
                  Text("Student ID",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  //student id text input
                  TextField(
                    style: TextStyle(
                      fontSize: 20,
                    ),
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
                  TextField(
                    style: TextStyle(
                      fontSize: 20,
                    ),
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
                  SizedBox(height: 10),

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

                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {},
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
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
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Color(0xFFD000B6),
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
