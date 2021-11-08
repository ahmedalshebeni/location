import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viewsoft_hr/main.dart';

class approveLeave extends StatefulWidget {
  @override
  _approveLeaveState createState() => _approveLeaveState();
}

class _approveLeaveState extends State<approveLeave> {
  var userInfo = '';

  void onPressed() async {
    print("object");
  }

  popend() {
    final snackBar = SnackBar(
      content: Text('تم تسجيل اتصراف لهذا اليوم من قبل'),
      action: SnackBarAction(
        label: 'ok',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  popstart() {
    final snackBar = SnackBar(
      content: Text('يجب تسجيل الحضور اولا'),
      action: SnackBarAction(
        label: 'ok',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  popinfo() {
    final snackBar = SnackBar(
      content: Text('تم تسجيل الحضور'),
      action: SnackBarAction(
        label: 'ok',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  popinfoend() {
    final snackBar = SnackBar(
      content: Text('تم تسجيل الانصراف'),
      action: SnackBarAction(
        label: 'ok',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  getprefrenc() async {
    // final SharedPreferences sharedPreferences =
    // await SharedPreferences.getInstance();
    // sharedPreferences.setString('name',);
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var name = prefs.getString('name');
    var adress= prefs.getString("address");
    print("emp_id :" + name);
    print("ip:"+adress);
    // userInfo = name;
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

  chkstartdate() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var name = prefs.getString('name');
    var adress= prefs.getString("address");
    String url =
        // 'http://41.32.222.242/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20count(*)%20cnt%20from%20mob_work_days%20where%20emp_id%20=%202%20and%20work_date%20=%20%2708-JUN-21%27%20and%20work_type=1';
        'http://$adress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20count(*)%20cnt%20from%20mob_work_days%20where%20emp_id%20=%20$name%20and%20work_date%20=%20%2708-JUN-21%27%20and%20work_type=1';
    http.Response response = await http.get(url);
    return json.decode(response.body);
  }

  chkenddate() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var name = prefs.getString('name');
    var adress= prefs.getString("address");
    String url =
    "http://192.168.1.50/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20count(*)%20cnt%20from%20mob_work_days%20where%20emp_id%20=%203%20and%20work_date%20=%20%2708-JUN-21%27%20and%20work_type=1%20and%20end_time%20is%20not%20null";
        // 'http://41.32.222.242/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20count(*)%20cnt%20from%20mob_work_days%20where%20emp_id%20=%202%20and%20work_date%20=%20%2708-JUN-21%27%20and%20work_type=1%20and%20end_time%20is%20not%20null';
        // 'http://$adress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20count(*)%20cnt%20from%20mob_work_days%20where%20emp_id%20=%20$name%20and%20work_date%20=%20%2708-JUN-21%27%20and%20work_type=1%20and%20end_time%20is%20not%20null';
    http.Response response = await http.get(url);
    return json.decode(response.body);
  }
  _storeOnboardInfo() async {
    print("Shared pref called");
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    print(prefs.getInt('onBoard'));
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

  getstartdate() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var name = prefs.getString('name');
    var adress= prefs.getString("address");

    String date =
        // 'http://41.32.222.242/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20to_char(sysdate,%27hh24:mi%27)%20start_time%20from%20dual';
        'http://$adress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20to_char(sysdate,%27hh24:mi%27)%20start_time%20from%20dual';
    http.Response response = await http.get(date);
    return json.decode(response.body);
  }

  getenddate() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var name = prefs.getString('name');
    var adress= prefs.getString("address");
    String date =
        // 'http://41.32.222.242/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20to_char(sysdate,%27hh24:mi%27)%20end_time%20from%20dual';
        'http://$adress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20to_char(sysdate,%27hh24:mi%27)%20end_time%20from%20dual';
    http.Response response = await http.get(date);
    return json.decode(response.body);
  }

  insertchekout() async {
    //get emp_id  '$_counter',
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var name = prefs.getString('name');
    var adress= prefs.getString("address");
    print("emp_id :" + name);
    print("ip:"+adress);
    _storeOnboardInfo();
    // userInfo = name;
    //get sysdate,start_date,end_date,work_type   var url="ddddsjdd'${name}'";
    Map datamap = await getdata();
    Map datemap = await getsysdate();
    Map Start_date = await getstartdate();
    Map end_date = await getenddate();
    Map check_end_date = await chkenddate();
    String check = datamap["data"][0]["count(*)"];
    String chkdate = datemap["data"][0]["sysdate"];
    String startdate = Start_date["data"][0]["start_time"];
    String Enddate = end_date["data"][0]["end_time"];
    String checkEndDate = check_end_date["data"][0]["cnt"];
    print("massage:" + checkEndDate  +  Enddate);
    // var urld="ddddsjdd'${check}'";
    //check if start_time found
    // if (checkEndDate == '0') {
    //
    // }
      // updateAlbum(String Enddate )async {
      //   return await http.put(
      //     Uri.parse(
      //         "http://41.32.222.242/php_rest_myblog/api/data/upd_tab.php?user=view&password=1&table=mob_work_days&where=emp_id=2 and work_date='08-JUN-21' and work_type=1"
      //     ),
      //     headers: <String, String>{
      //       'Content-Type': 'application/json; charset=UTF-8',
      //     },
      //     body: jsonEncode(<String, String>{
      //       'end_time': Enddate,
      //     }),
      //   );
      // }

    if (checkEndDate != '0') {
      popend();
    }
      final msg = json.encode({
          "end_time": Enddate,
      });
       print("massage2:" + checkEndDate+Enddate);
      var url = Uri.parse(

          "http://$adress/php_rest_myblog/api/data/upd_tab.php?user=view&password=1&table=mob_work_days&where=emp_id=$name and work_date=$chkdate and work_type=1");
          // "http://41.32.222.242/php_rest_myblog/api/data/upd_tab.php?user=view&password=1&table=mob_work_days&where=emp_id=2 and work_date='08-JUN-21' and work_type=1");
 // // 'http://41.32.222.242/php_rest_myblog/api/data/upd_tab.php?user=view&password=1&table=mob_work_days&where=emp_id=2%20and%20work_date=%2708-JUN-20%27%20and%20work_type=1');
      http.Response response = await http.post(url, body: msg, headers: {"content-type": "application/json"});
 //      // print("done" + response.body);
 //       print("result"+jsonDecode(response.body)['Enddate']);
    print("done");
    popinfoend();
      if (response.statusCode == 201) {
              return Album.fromJson(jsonDecode(response.body));

      } else {
        throw Exception('Failed to create .'+response.body);
      }

    }


  insertchekin() async {
    //get emp_id
    // int view=0;
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setInt("onboard", view);
    var name = prefs.getString('name');
    var adress= prefs.getString("address");
    print("emp_id :" + name);
    print("ip:"+adress);
    userInfo = name;
    _storeOnboardInfo();
    //get sysdate,start_date,end_date,work_type
    Map datamap = await getdata();
    Map datemap = await getsysdate();
    Map Start_date = await getstartdate();
    Map end_date = await getenddate();
    Map check_start_date = await chkstartdate();
    String check = datamap["data"][0]["count(*)"];
    String chkdate = datemap["data"][0]["sysdate"];
    String startdate = Start_date["data"][0]["start_time"];
    String Enddate = end_date["data"][0]["end_time"];
    String checkStartDate = check_start_date["data"][0]["cnt"];
    print("massage");
    //check if start_time found
    if (checkStartDate == '0') {
      popstart();
    }
    final msg = json.encode({
      "emp_id": name,
      "work_date": chkdate,
      "work_type": 1,
      "start_time": startdate,
      "end_time": Enddate ,
    });
    var url = Uri.parse(
        'http://$adress/php_rest_myblog/api/data/ins_tab.php?user=view&password=1&table=mob_work_days'
        // 'http://41.32.222.242/php_rest_myblog/api/data/ins_tab.php?user=view&password=1&table=mob_work_days'
    );
    http.Response response = await http
        .post(url, body: msg, headers: {"content-type": "application/json"});
    print("done" + response.body);
    popinfo();
    // print("result"+jsonDecode(response.body)['name']);
    if (response.statusCode == 201) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create .');
    }

  }


  
    /*
    *
  Future<void> makePutRequest() async {
    resultNotifier.value = RequestLoadInProgress();
    final url = Uri.parse('$urlPrefix/posts/1');
    final headers = {"Content-type": "application/json"};
    final json = '{"title": "Hello", "body": "body text", "userId": 1}';
    final response = await put(url, headers: headers, body: json);
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
    _handleResponse(response);
  }
    *
    *
    *
    *
    *
    * */
 //    final msg = json.encode({
 //      "emp_id": name,
 //      "work_date": chkdate,
 //      "work_type": 1,
 //      "start_time": startdate,
 //      "end_time": Enddate,
 //    });
 //    var url = Uri.parse(
 //        'http://41.32.222.242/php_rest_myblog/api/data/ins_tab.php?user=view&password=1&table=mob_work_days');
 //    http.Response response = await http
 //        .post(url, body: msg, headers: {"content-type": "application/json"});
 //    print("done" + response.body);
 //    popend();
 //    // print("result"+jsonDecode(response.body)['name']);
 //    if (response.statusCode == 201) {
 //      return Album.fromJson(jsonDecode(response.body));
 //    } else {
 //      throw Exception('Failed to create .');
 //    }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.deepPurple,
        title: new Text('Main Page'),
      ),
      body: new Container(
        padding: EdgeInsets.all(50.50),
        margin: EdgeInsets.only(right: 40.0),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              new Image.asset(
                'img/viewsoft.png',
                // img/1.jpg  img/userbackground.png img/viewsoft.png
                height: 100.0,
                width: 100.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
              ),
              new Padding(
                padding: EdgeInsets.all(10.0),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: new RaisedButton(
                  onPressed: insertchekin,
                  // getprefrenc,
                  child: new Text("تسجيل الحضور"),
                  color: Colors.deepPurple,
                  textColor: Colors.white,
                ),
              ),
              new Padding(
                padding: EdgeInsets.all(10.0),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: new RaisedButton(
                  onPressed: insertchekout,
                  // getprefrenc,
                  child: new Text("تسجيل الانصراف"),
                  color: Colors.deepPurple,
                  textColor: Colors.white,
                ),
              ),
              new Text(
                '$userInfo',
                style: TextStyle(color: Colors.deepPurple, fontSize: 18.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
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


