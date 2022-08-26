import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String? answerText;
  Answer({this.answerText});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(15.0),
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          answerText.toString(),
          style: TextStyle(fontSize: 15.0),
        ),
      ),
    );
  }
}
