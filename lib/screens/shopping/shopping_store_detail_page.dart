import 'package:firebase_database/firebase_database.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_malai/user_info.dart';

import '../../config.dart';
import '../../theme.dart';

class ShoppingStoreDetailPage extends StatefulWidget {
  @override
  _ShoppingStoreDetailPageState createState() => _ShoppingStoreDetailPageState();
}

class _ShoppingStoreDetailPageState extends State<ShoppingStoreDetailPage> {

  final databaseRef = FirebaseDatabase.instance.reference();

  List<String> itemsInStore = new List();
  List<double> percents = new List();

  @override
  void initState() {
    super.initState();
    databaseRef.child("users").child(userID).child("potentialTrips").onChildAdded.listen((Event event) {
      setState(() {
        itemsInStore.add(event.snapshot.value["items"]);
        percents.add(double.parse(event.snapshot.value["percentOfList"]));
      });
    });
  }

  void updateTrip(String time) {
    databaseRef.child("users").child(userID).child("trips").child(selectedStore.id).set({
      "items": {
        "corn": 3,
        "bread": 5,
        "eggs": 1
      },
      "time": time
    });
    databaseRef.child("users").child(userID).child("shoppingList").child("corn").set(null);
    databaseRef.child("users").child(userID).child("shoppingList").child("bread").set(null);
    databaseRef.child("users").child(userID).child("shoppingList").child("eggs").set(null);
    showDialog(context: context, child: new AlertDialog(
      title: new Text("Added Store to Trip!"),
      actions: <Widget>[
        new FlatButton(onPressed: () => router.navigateTo(context, '/home', transition: TransitionType.fadeIn, clearStack: true), child: new Text("GOT IT"))
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(selectedStore.name),
        actions: <Widget>[
        ],
      ),
      backgroundColor: currBackgroundColor,
      body: new Container(
        padding: EdgeInsets.all(16),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              height: 200,
              child: new ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                child: new GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(37.27869, -121.83572),
                      zoom: 14.0
                  ),
                  compassEnabled: false,
                  myLocationButtonEnabled: false,
                  markers: Set<Marker>.from([
                    Marker(
                        markerId: MarkerId(selectedStore.id),
                        position: LatLng(37.27869, -121.83572),
                        infoWindow: InfoWindow(title: selectedStore.name)
                    )
                  ]),
                ),
              ),
            ),
            new Padding(padding: EdgeInsets.all(8)),
            new Text(selectedStore.address, style: TextStyle(color: currTextColor, fontSize: 17),),
            new Padding(padding: EdgeInsets.all(8)),
            new Text("Available Items: " + itemsInStore[0] + "\n${percents[0]*100}% of list", style: TextStyle(color: currTextColor, fontSize: 17),),
            new Padding(padding: EdgeInsets.all(8)),
            new Text("Time Slots", style: TextStyle(color: currTextColor, fontSize: 17, fontWeight: FontWeight.bold),),
            new ListTile(
              title: new Text("11:00", style: TextStyle(color: currTextColor),),
              trailing: new Chip(label: new Text("Packed", style: TextStyle(color: Colors.white),), backgroundColor: Colors.red,),
            ),
            new ListTile(
              title: new Text("12:00", style: TextStyle(color: currTextColor),),
              onTap: () {
                updateTrip("12:00");
              },
              trailing: new Chip(label: new Text("Busy", style: TextStyle(color: Colors.white),), backgroundColor: Colors.orangeAccent,),
            ),
            new ListTile(
              title: new Text("1:00", style: TextStyle(color: currTextColor),),
              onTap: () {
                updateTrip("1:00");
              },
              trailing: new Chip(label: new Text("Busy", style: TextStyle(color: Colors.white),), backgroundColor: Colors.orangeAccent,),
            ),
            new ListTile(
              title: new Text("2:00", style: TextStyle(color: currTextColor),),
              onTap: () {
                updateTrip("2:00");
              },
              trailing: new Chip(label: new Text("Space", style: TextStyle(color: Colors.white),), backgroundColor: Colors.green,),
            ),
            new ListTile(
              title: new Text("3:00", style: TextStyle(color: currTextColor),),
              onTap: () {
                updateTrip("3:00");
              },
              trailing: new Chip(label: new Text("Busy", style: TextStyle(color: Colors.white),), backgroundColor: Colors.orangeAccent,),
            )
          ],
        ),
      ),
    );
  }
}
