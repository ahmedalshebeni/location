
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LeaveHistory extends StatefulWidget {
  @override
  _LeaveHistoryState createState() => _LeaveHistoryState();
}

class _LeaveHistoryState extends State<LeaveHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          backgroundColor: Colors.deepPurple,
          title: new Text('LeaveHistory Page')
      ),
      body: new Container(),
    );
  }
}
