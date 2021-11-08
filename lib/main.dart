import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'Gui/LeaveHistory.dart';
import 'Gui/LeaveRequest.dart';
import 'Gui/approve Leave.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Gui/loction.dart';

class Album {
  final int emp_id;
  final DateTime work_date;
  final int work_type;
  final String start_time;
  final String end_time;

  Album(
      {this.emp_id,
        this.work_date,
        this.work_type,
        this.start_time,
        this.end_time});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      emp_id: json['emp_id'],
      work_date: json['work_date'],
      work_type: json['work_type'],
      start_time: json['start_time'],
      end_time: json['end_time'],
    );
  }
}
int  isviewed;
// var viewname,viewadress;
void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('onBoard');

  // home: isviewed != 0 ? approveLeave() : splash2();
  // List data = await getData();
  // String mydata = data[0]['title'];

  runApp(MyApp());
}
String now = DateFormat("yyyy-MM-dd hh :mm:ss").format(DateTime.now());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/First': (BuildContext context) => new LeaveRequest(),
        '/Second': (BuildContext context) => new approveLeave(),
        '/Third': (BuildContext context) => new LeaveHistory(),

      },
      home: location(),
      // home: isviewed != 0 ? approveLeave() : Home(),
      // home: splash2(),
      //  home: ("$viewname  && $viewadress" != 0 )? splash2() : approveLeave() ,
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen1 extends StatefulWidget {
  @override
  Splash createState() => Splash();
}

class Splash extends State<SplashScreen1> {
  void initstate() {
    super.initState();

    Timer(
      Duration(seconds: 3),
      () =>
          //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>homepage())),
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home())),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      //child: Image.network('https://mostaql.hsoubcdn.com/uploads/530270-8I7aa-1556371888-5cc459b0510a5.jpg'),
      child:
          Image.network('https://i.vimeocdn.com/portrait/26270325_120x120.jpg'),
    );
  }
}

class homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage'),
      ),
      body: Center(
        child: Text("welcome"),
      ),
    );
  }
}

class Home extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return new HomeState();

    }
}

TextEditingController _userController = new TextEditingController();
TextEditingController ipaddress = new TextEditingController();
TextEditingController _passwordController = new TextEditingController();
var  viewname= _userController.text;
var viewadress = ipaddress.text;
class HomeState extends State<Home> {
   // TextEditingController _userController = new TextEditingController();
   // TextEditingController ipaddress = new TextEditingController();
   TextEditingController _passwordController = new TextEditingController();
  int _value = 1;
  String userInfo = '';
  bool Shown = true;
  void _onLogin() async {
    // String isViewed = "";
     SharedPreferences sharedPreferences =    await SharedPreferences.getInstance();
    sharedPreferences.setString('name', _userController.text);
    sharedPreferences.setString('address',ipaddress.text);
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var name = prefs.getString('name');
    var adress= prefs.getString("address");
     print(name  +   adress);
    print(_userController.text);
    Map datamap = await getdata();
    Map datemap = await getsysdate();
    String check = datamap["data"][0]["count(*)"];
    String chkdate = datemap["data"][0]["sysdate"];
    print(check);
    print(chkdate);
    setState(()  {
      if (check == '0' ) {

        // Navigator.of(context).pushNamed('/Second');
        Navigator.pushReplacementNamed(context, '/Second');
      }
      else {
        userInfo = 'you Name or Ip is Invalid:';
      }
      // datamap.forEach((key, val) {
      //   if(val==_userController.text ) {
      //     // print("object");
      //   }
      //   else{
      //
      //     print("teh ::"+x);
      //     // print("gfg:"+key);
      //   }
      // });
      // if (_userController.text.trim().isEmpty &&
      //     _passwordController.text.trim().isEmpty) {
      //   userInfo = 'Please enter you name and password';
      // } else {
      //   userInfo = 'Welcome ${_userController.text}';
      //   Navigator.of(context).pushNamed('/Second');
      // }

    });

    print('Logged in !');
  }

  void _onClear() {
    setState(() {
      _userController.clear();
      _passwordController.clear();
    });
    print('Clearing !');
  }

  insert() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var name = prefs.getString('name');
    var adress= prefs.getString("address");
    print("massage");
    // final msg = json.encode({"name":name.text,"password":password.text});
    final msg = json.encode({"emp_id": _userController.text, "password": _passwordController,"address":ipaddress});
    var url = Uri.parse(
        'http://$adress/php_rest_myblog/api/data/ins_tab.php?user=view&password=1&table=mob_work_days');
        // 'http://41.32.222.242/php_rest_myblog/api/data/ins_tab.php?user=view&password=1&table=mob_work_days');
    http.Response response = await http
        .post(url, body: msg, headers: {"content-type": "application/json"});
    print("dfgg" + response.body);
    // print("result"+jsonDecode(response.body)['name']);
    if (response.statusCode == 201) {
      return Album.fromJson(jsonDecode(response.body)['emp_id']);
    } else {
      throw Exception('Failed to create .');
    }
  }

  getdata() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var name = prefs.getString('name');
    var adress= prefs.getString("address");
    String url =
        // 'http://41.32.222.242/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select count(*) from hr_emp where emp_id=2 and v_flex10=123';
        'http://$adress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select count(*) from hr_emp where emp_id=$name and v_flex10=123';
    http.Response response = await http.get(url);
    return json.decode(response.body);
  }

  getsysdate() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var name = prefs.getString('name');
    var adress= prefs.getString("address");
    String date =
        // 'http://41.32.222.242/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20sysdate%20from%20dual';
        'http://$adress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20sysdate%20from%20dual';
    http.Response response = await http.get(date);
    return json.decode(response.body);
  }

  checkingTheSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.containsKey('username') as String;
    if (username == null) {
      Navigator.pushReplacementNamed(context, '/Second');
    } else {
      Navigator.pushReplacementNamed(context, '/First');
    }
  }

  getpref() async {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('name', _userController.text);
      sharedPreferences.setString('address', ipaddress.text);
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var name = prefs.getString('name');
      var adress= prefs.getString("address");
      print(name+adress);
      print(_userController.text);
      Navigator.of(context).pushNamed('/Second');
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('TextField AlertDemo'),
            content: TextField(
              decoration: InputDecoration(hintText: "TextField in Dialog"),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('SUBMIT'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Simple Alert"),
      content: Text("This is an alert message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  pop(){
    final snackBar = SnackBar(
      content: Text('Yay! A SnackBar!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          backgroundColor: Colors.deepPurple, title: new Text('Login Page')),
      body: new Container(
        padding: EdgeInsets.all(2.4),
        alignment: Alignment.center,
        child: new ListView(
          children: <Widget>[
            new Image.asset(
              'img/viewsoft.png',
              // img/1.jpg  img/userbackground.png img/viewsoft.png
              height: 100.0,
              width: 100.0,
            ),
            new Container(
              padding: EdgeInsets.all(0.0),
              height: 20.0,
              width: 30.0,
              child: new Column(
                children: <Widget>[],
              ),
            ),
            new Padding(
              padding: EdgeInsets.all(10.0),
            ),
            new TextField(
              style: TextStyle(fontSize: 18.0, color: Colors.deepPurple),
              controller: _userController,
              decoration: InputDecoration(
                  icon: new Icon(
                    Icons.person,
                    color: Colors.deepPurple,
                    size: 20.0,
                  ),
                  hintText: 'Your Name'),
              keyboardType: TextInputType.number,
            ),
            new Padding(
              padding: EdgeInsets.all(13.0),
            ),
            new TextField(
              style: TextStyle(fontSize: 18.0, color: Colors.deepPurple),
              controller: ipaddress,
              decoration: InputDecoration(
                  icon: new Icon(
                    Icons.person,
                    color: Colors.deepPurple,
                    size: 20.0,
                  ),
                  hintText: 'Your address'),
              keyboardType: TextInputType.number,
            ),
            new Padding(
              padding: EdgeInsets.all(13.0),
            ),
            new TextField(
              style: TextStyle(fontSize: 18.0, color: Colors.deepPurple),
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                icon: new Icon(
                  Icons.lock,
                  color: Colors.deepPurple,
                  size: 20.0,
                ),
                hintText: 'Password',
              ),
            ),
            new Container(
              margin: EdgeInsets.only(left: 73.0),

            ),

            new Padding(
              padding: EdgeInsets.all(13.0),
            ),
            new Center(
              child: new Row(
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.only(left: 180.0),
                    child: new FlatButton(
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                      onPressed:
                      // checkingTheSavedData(),
                       // _displayDialog(context),
                       // getpref,
                       _onLogin,
                      //  () => Navigator.pop(context, 'OK'),
                      //  () => {
                      //  Navigator.of(context).pushNamed('/Second')
                      // },
                      //  pop,
                      child: new Text(
                        'Login',
                      ),
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.only(left: 73.0),
                    // child:   new FlatButton(
                    //   color: Colors.deepOrange,
                    //   textColor: Colors.white,
                    //   onPressed: _onClear,
                    //   child: new Text('Clear'),
                    // ),
                  ),
                ],
              ),
            ),
            new Padding(
              padding: EdgeInsets.all(23.0),
            ),
            new Container(
              child: new Text(
                '$userInfo',
                style: TextStyle(color: Colors.deepPurple, fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class Album {
//   final int emp_id;
//   final DateTime work_date;
//   final int work_type;
//   final String start_time;
//   final String end_time;
//
//   Album(
//       {this.emp_id,
//       this.work_date,
//       this.work_type,
//       this.start_time,
//       this.end_time});
//
//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       emp_id: json['emp_id'],
//       work_date: json['work_date'],
//       work_type: json['work_type'],
//       start_time: json['start_time'],
//       end_time: json['end_time'],
//     );
//   }
// }

class splash2 extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: Home(),
      // image: Image.network('https://mostaql.hsoubcdn.com/uploads/530270-8I7aa-1556371888-5cc459b0510a5.jpg'),
      // image: Image.asset("img/viewsoft.png"),
      image:
          Image.network('https://i.vimeocdn.com/portrait/26270325_120x120.jpg'),
      photoSize: 100.0,
      loadingText: Text("loading"),
      loaderColor: Colors.blue,

    );
  }
}
