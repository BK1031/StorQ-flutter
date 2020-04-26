import 'package:firebase_database/firebase_database.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_malai/models/item.dart';
import 'package:project_malai/models/store.dart';
import 'package:project_malai/theme.dart';
import 'package:project_malai/user_info.dart';

import '../../app_drawer.dart';
import '../../config.dart';

class ShoppingStorePage extends StatefulWidget {
  @override
  _ShoppingStorePageState createState() => _ShoppingStorePageState();
}

class _ShoppingStorePageState extends State<ShoppingStorePage> {

  final databaseRef = FirebaseDatabase.instance.reference();

  List<Store> storeList = new List();
  List<String> itemsInStore = new List();
  List<double> percents = new List();

  @override
  void initState() {
    super.initState();
    databaseRef.child("users").child(userID).child("potentialTrips").onChildAdded.listen((Event event) {
      Store store = new Store();
      store.id = event.snapshot.key;
      print(store.id);
      databaseRef.child("stores").child(store.id).once().then((DataSnapshot snapshot) {
        store.name = snapshot.value["name"];
        store.address = snapshot.value["address"];
        store.lat = snapshot.value["lat"];
        store.long = snapshot.value["long"];
      });
      setState(() {
        itemsInStore.add(event.snapshot.value["items"]);
        percents.add(double.parse(event.snapshot.value["percentOfList"]));
        storeList.add(store);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Nearby Stores"),
        actions: <Widget>[
        ],
      ),
      backgroundColor: currBackgroundColor,
      body: new Container(
          padding: EdgeInsets.all(8),
          child: new ListView.builder(
            itemCount: storeList.length,
            itemBuilder: (context, index) {
              return new GestureDetector(
                onTap: () {
                  selectedStore = storeList[index];
                  router.navigateTo(context, '/shopping-store/details', transition: TransitionType.cupertino);
                },
                child: new Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  color: currCardColor,
                  child: new Container(
                    padding: EdgeInsets.all(16),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                                    markerId: MarkerId(storeList[index].id),
                                    position: LatLng(storeList[index].lat, storeList[index].long),
                                    infoWindow: InfoWindow(title: storeList[index].name)
                                )
                              ]),
                            ),
                          ),
                        ),
                        new Padding(padding: EdgeInsets.all(8)),
                        new Text(storeList[index].name, style: TextStyle(color: currTextColor, fontSize: 25, fontWeight: FontWeight.bold),),
                        new Text("Available Items: " + itemsInStore[index] + "\n${percents[index]*100}% of list", style: TextStyle(color: currTextColor, fontSize: 17),),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
      ),
    );
  }
}
