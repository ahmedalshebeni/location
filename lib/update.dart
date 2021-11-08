// import 'dart:async';
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// Future<Album> fetchAlbum() async {
//   final response = await http.get(
//     Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
//   );
//
//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return Album.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }
//
// Future<Album> updateAlbum(String title) async {
//   final response = await http.put(
//     Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'title': title,
//     }),
//   );
//
//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return Album.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to update album.');
//   }
// }
//
// class Album {
//   final int id;
//   final String title;
//
//   Album({ this.id, this.title});
//
//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       id: json['id'],
//       title: json['title'],
//     );
//   }
// }
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   MyApp({key}) : super(key: key);
//
//   @override
//   _MyAppState createState() {
//     return _MyAppState();
//   }
// }
//
// class _MyAppState extends State<MyApp> {
//   final TextEditingController _controller = TextEditingController();
//  Future<Album> _futureAlbum;
//
//   @override
//   void initState() {
//     super.initState();
//     _futureAlbum = fetchAlbum();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Update Data Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Update Data Example'),
//         ),
//         body: Container(
//           alignment: Alignment.center,
//           padding: const EdgeInsets.all(8.0),
//           child: FutureBuilder<Album>(
//             future: _futureAlbum,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 if (snapshot.hasData) {
//                   return Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Text(snapshot.data.title),
//                       TextField(
//                         controller: _controller,
//                         decoration: InputDecoration(hintText: 'Enter Title'),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             _futureAlbum = updateAlbum(_controller.text);
//                           });
//                         },
//                         child: Text('Update Data'),
//                       ),
//                     ],
//                   );
//                 } else if (snapshot.hasError) {
//                   return Text('${snapshot.error}');
//                 }
//               }
//
//               return CircularProgressIndicator();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared preferences demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Shared preferences demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key,  this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  //Loading counter value on start
  void _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0);
    });
  }

  //Incrementing counter after click
  void _incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0) + 1;
      prefs.setInt('counter', _counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// import "package:flutter/material.dart";
//
// void main() {
//   runApp(new ControlleApp());
// }
//
// class ControlleApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: "My App",
//       home: new HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   @override
//   HomePageState createState() => new HomePageState();
// }
//
// class HomePageState extends State<HomePage> {
//   bool visibilityTag = false;
//   bool visibilityObs = false;
//
//   void _changed(bool visibility, String field) {
//     setState(() {
//       if (field == "tag"){
//         visibilityTag = visibility;
//       }
//       if (field == "obs"){
//         visibilityObs = visibility;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context){
//     return new Scaffold(
//         appBar: new AppBar(backgroundColor: new Color(0xFF26C6DA)),
//         body: new ListView(
//           children: <Widget>[
//             new Container(
//               margin: new EdgeInsets.all(20.0),
//               child: new FlutterLogo(size: 100.0, textColor:  Colors.blue),
//             ),
//             new Container(
//                 margin: new EdgeInsets.only(left: 16.0, right: 16.0),
//                 child: new Column(
//                   children: <Widget>[
//                     visibilityObs ? new Row(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: <Widget>[
//                         new Expanded(
//                           flex: 11,
//                           child: new TextField(
//                             maxLines: 1,
//                             style: Theme.of(context).textTheme.title,
//                             decoration: new InputDecoration(
//                                 labelText: "Observation",
//                                 isDense: true
//                             ),
//                           ),
//                         ),
//                         new Expanded(
//                           flex: 1,
//                           child: new IconButton(
//                             color: Colors.grey[400],
//                             icon: const Icon(Icons.cancel, size: 22.0,),
//                             onPressed: () {
//                               _changed(false, "obs");
//                             },
//                           ),
//                         ),
//                       ],
//                     ) : new Container(),
//
//                     visibilityTag ? new Row(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: <Widget>[
//                         new Expanded(
//                           flex: 11,
//                           child: new TextField(
//                             maxLines: 1,
//                             style: Theme.of(context).textTheme.title,
//                             decoration: new InputDecoration(
//                                 labelText: "Tags",
//                                 isDense: true
//                             ),
//                           ),
//                         ),
//                         new Expanded(
//                           flex: 1,
//                           child: new IconButton(
//                             color: Colors.grey[400],
//                             icon: const Icon(Icons.cancel, size: 22.0,),
//                             onPressed: () {
//                               _changed(false, "tag");
//                             },
//                           ),
//                         ),
//                       ],
//                     ) : new Container(),
//                   ],
//                 )
//             ),
//             new Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 new InkWell(
//                     onTap: () {
//                       visibilityObs ? null : _changed(true, "obs");
//                     },
//                     child: new Container(
//                       margin: new EdgeInsets.only(top: 16.0),
//                       child: new Column(
//                         children: <Widget>[
//                           new Icon(Icons.comment, color: visibilityObs ? Colors.grey[400] : Colors.grey[600]),
//                           new Container(
//                             margin: const EdgeInsets.only(top: 8.0),
//                             child: new Text(
//                               "Observation",
//                               style: new TextStyle(
//                                 fontSize: 12.0,
//                                 fontWeight: FontWeight.w400,
//                                 color: visibilityObs ? Colors.grey[400] : Colors.grey[600],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                 ),
//                 new SizedBox(width: 24.0),
//                 new InkWell(
//                     onTap: () {
//                       visibilityTag ? null : _changed(true, "tag");
//                     },
//                     child: new Container(
//                       margin: new EdgeInsets.only(top: 16.0),
//                       child: new Column(
//                         children: <Widget>[
//                           new Icon(Icons.local_offer, color: visibilityTag ? Colors.grey[400] : Colors.grey[600]),
//                           new Container(
//                             margin: const EdgeInsets.only(top: 8.0),
//                             child: new Text(
//                               "Tags",
//                               style: new TextStyle(
//                                 fontSize: 12.0,
//                                 fontWeight: FontWeight.w400,
//                                 color: visibilityTag ? Colors.grey[400] : Colors.grey[600],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                 ),
//               ],
//             )
//           ],
//         )
//     );
//   }
// }