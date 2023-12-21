import 'package:flutter/material.dart';

class CustomAppBar<T> extends StatelessWidget implements PreferredSizeWidget{
  final String title;

    CustomAppBar({
      required this.title,
  });
  @override
  Widget build(BuildContext context){
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/login');
        },
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}