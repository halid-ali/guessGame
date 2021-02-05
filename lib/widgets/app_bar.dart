import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;

  const CustomAppBar({
    Key key,
    this.title = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
      ),
      backgroundColor: Colors.pink,
    );
  }
}
