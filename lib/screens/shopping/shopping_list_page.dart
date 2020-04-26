import 'package:firebase_database/firebase_database.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:project_malai/models/item.dart';
import 'package:project_malai/theme.dart';
import 'package:project_malai/user_info.dart';

import '../../app_drawer.dart';
import '../../config.dart';

class ShoppingListPage extends StatefulWidget {
  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {

  final databaseRef = FirebaseDatabase.instance.reference();
  
  @override
  void initState() {
    super.initState();
    shoppingList.clear();
    databaseRef.child("users").child(userID).child("shoppingList").onChildAdded.listen((Event event) {
      setState(() {
        Item item = new Item();
        item.name = event.snapshot.key;
        item.quantity = event.snapshot.value;
        shoppingList.add(item);
      });
    });
  }

  void addItem() {
    String name = "";
    int quantity = 0;
    showDialog(context: context, child: new AlertDialog(
      title: new Text("Add Item"),
      backgroundColor: currCardColor,
      content: new Container(
        height: 200,
        child: new Column(
          children: <Widget>[
            new TextField(
              style: TextStyle(color: currTextColor),
              decoration: InputDecoration(
                  hintText: "Item Name",
              ),
              onChanged: (val) {
                name = val;
              },
            ),
            new TextField(
              style: TextStyle(color: currTextColor),
              decoration: InputDecoration(
                hintText: "Quantity"
              ),
              onChanged: (val) {
                quantity = int.parse(val);
              },
            )
          ],
        ),
      ),
      actions: <Widget>[
        new FlatButton(onPressed: () => router.pop(context), child: new Text("CANCEL")),
        new FlatButton(
          child: new Text("ADD"),
          onPressed: () {
            databaseRef.child("users").child(userID).child("shoppingList").child(name).set(quantity);
            router.pop(context);
          },
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Shopping List"),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.add), onPressed: addItem)
        ],
      ),
      drawer: new AppDrawer(),
      backgroundColor: currBackgroundColor,
      floatingActionButton: new FloatingActionButton.extended(
        label: new Text("FIND STORES"),
        onPressed: () {
          router.navigateTo(context, '/shopping-store', transition: TransitionType.cupertino);
        },
      ),
      body: new Container(
        child: new ListView.builder(
          itemCount: shoppingList.length,
          itemBuilder: (context, index) {
            return new ListTile(
              title: new Text(shoppingList[index].name, style: TextStyle(color: currTextColor),),
              trailing: new Text(shoppingList[index].quantity.toString(), style: TextStyle(color: currTextColor),),
            );
          },
        )
      ),
    );
  }
}
