import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';

// void main() => runApp(App());

class location extends StatefulWidget {
  @override
  _locationState createState() => _locationState();

}

class _locationState extends State<location> {
  final double limit = 50.0;
  String _locationMessage = "";

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)) * 1000;
  }

   _getCurrentLocation(BuildContext context ) async {
    final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    if (position.latitude != null && position.longitude != null) {
      final distance = calculateDistance(
          position.latitude, position.longitude, 30.0418050, 31.3718450);//location ahmed
    // position.latitude, position.longitude, 30.0482150, 31.3686650);//loctain viewsoft
      print('Distsnce ::::::: $distance');
      if (distance <= limit) {
        //TODO
         ScaffoldMessenger.of(context).showSnackBar(  SnackBar(content: Text('success login.', style: TextStyle(color: Colors.white))));
        print('Can access !');
        // final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);



      } else {
        ScaffoldMessenger.of(context).showSnackBar(  SnackBar(content: Text('ICan not access the distance is bigger than the limit $distance > $limit !', style: TextStyle(color: Colors.white))));
        print(
            'Can not access the distance is bigger than the limit $distance > $limit !');
      }
    }
    setState(() {
      // _locationMessage = "${position.latitude}, ${position.longitude}";
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(title: Text("Location Services")),
            body:  Builder(
              builder: (context)=>
          Center(
            child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(_locationMessage),
                  MaterialButton(
                      onPressed: () {
                        _getCurrentLocation(context);
                       // Scaffold.of(context).showSnackBar( SnackBar(content: Text('hrr'),));
                      },
                      color: Colors.green,
                      child: Text("Find Location"))
                ]),
          ),
                   ),
            ),
            );
  }
}
