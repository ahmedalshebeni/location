import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'LeaveHistory.dart';
import 'approve Leave.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LeaveRequest2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/First': (BuildContext context) => new LeaveRequest(),
        '/Second': (BuildContext context) => new approveLeave(),
        '/Third': (BuildContext context) => new LeaveHistory(),
      },
      home: LeaveRequest(),
    );
  }
}

class LeaveRequest extends StatefulWidget {
  @override
  _LeaveRequestState createState() => _LeaveRequestState();
}

class _LeaveRequestState extends State<LeaveRequest> {
  String txt = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          backgroundColor: Colors.deepPurple, title: new Text('Main Page')),
      // body:new Stack(
      //  children: [
      //    FlatButton(
      //      color: Colors.blue,
      //      child: Text('Flat Button',),
      //      onPressed: () {
      //        setState(() {
      //          txt='FlatButton tapped';
      //        });
      //      },
      //    ),
      //   ]
      // )
      body: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Side menu',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              decoration: BoxDecoration(
                  color: Colors.green,
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage('img/viewsoft.png'))),
            ),
            ListTile(
              leading: Icon(Icons.input),
              title: Text('LeaveRequest'),
              onTap: () => {},
            ),
            ListTile(
              leading: Icon(Icons.alarm_add),
              title: Text('I_time'),
              onTap: () => {Navigator.of(context).pushNamed('/First')},
            ),
            ListTile(
              leading: Icon(Icons.addchart),
              title: Text('PayRollReport'),
              onTap: () => {
                if (Navigator.of(context).canPop())
                  {Navigator.of(context).pushReplacementNamed('/Second')}
                else
                  {Navigator.of(context).pushNamed('/Second')}
              }, //Navigator.of(context).pushNamed('/First');Navigator.of(context).pop()
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('ChangePassword'),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () => {Navigator.of(context).pop()},
            ),
          ],
        ),
      ),
    );
  }
}
