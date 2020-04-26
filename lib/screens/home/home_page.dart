import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_malai/app_drawer.dart';
import 'package:project_malai/models/store.dart';
import 'package:project_malai/theme.dart';
import 'package:project_malai/user_info.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.275812, -121.826931),
    zoom: 14.4746,
  );

  List<Store> storeList = new List();

  final databaseRef = FirebaseDatabase.instance.reference();
  
  bool showTrip = false;
  String time = "1:00";

  @override
  void initState() {
    super.initState();
    databaseRef.child("users").child(userID).child("trips").child(selectedStore.id).child("time").once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        setState(() {
          time = snapshot.value;
          showTrip = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),
      ),
      drawer: new AppDrawer(),
      backgroundColor: currBackgroundColor,
      body: new Container(
        child: new Stack(
          children: <Widget>[
            new GoogleMap(
              initialCameraPosition: _kGooglePlex,
              myLocationEnabled: true,
              markers: Set<Marker>.from([
                Marker(
                    markerId: MarkerId("wal1"),
                    position: LatLng(37.27869, -121.83572),
                    infoWindow: InfoWindow(title: "Walmart")
                ),
                Marker(
                    markerId: MarkerId("wal2"),
                    position: LatLng(37.284712, -121.832538),
                    infoWindow: InfoWindow(title: "Costco")
                ),
                Marker(
                    markerId: MarkerId("wal3"),
                    position: LatLng(37.284441, -121.821605),
                    infoWindow: InfoWindow(title: "Walgreens")
                )
              ]),
              myLocationButtonEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            new Visibility(
              visible: showTrip,
              child: new Container(
                padding: EdgeInsets.all(8),
                height: 125, width: 1000,
                child: new Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  color: currCardColor,
                  child: new Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Container(
                          width: 80,
                          child: Center(
                            child: new Text(
                              time,
                              style: TextStyle(color: mainColor, fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                          ),
                        ),
                        new Expanded(
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text("Walmart", style: TextStyle(color: currTextColor, fontWeight: FontWeight.bold, fontSize: 20),),
                              new Text("Items at Store:\neggs, bread, corn", style: TextStyle(color: currTextColor, fontSize: 17),),
                            ],
                          ),
                        ),
                        new Container(
                          width: 80,
                          child: Center(
                            child: new Icon(Icons.notifications_active, color: mainColor,)
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
