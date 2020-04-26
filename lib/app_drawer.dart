import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:project_malai/config.dart';
import 'package:project_malai/screens/startup/auth_functions.dart';
import 'package:project_malai/theme.dart';
import 'package:project_malai/user_info.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      color: currBackgroundColor,
      child: new SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Column(
              children: <Widget>[
                new Padding(padding: EdgeInsets.all(16)),
                new ClipRRect(borderRadius: BorderRadius.all(Radius.circular(75)), child: new Image.network(profilePic, width: 125, height: 125,)),
                new Padding(padding: EdgeInsets.all(8)),
                new Text(name, style: TextStyle(fontSize: 25, color: currTextColor),),
                new Text(email, style: TextStyle(fontSize: 20, color: Colors.grey),),
                new Padding(padding: EdgeInsets.all(16)),
                new ListTile(
                  title: new Text("Home", style: TextStyle(color: currTextColor, fontSize: 17),),
                  leading: new Icon(Icons.home, color: Colors.grey,),
                  onTap: () {
                    router.pop(context);
                    router.navigateTo(context, '/home', transition: TransitionType.fadeIn);
                  },
                ),
                new ListTile(
                  title: new Text("Shopping List", style: TextStyle(color: currTextColor, fontSize: 17),),
                  leading: new Icon(Icons.list, color: Colors.grey,),
                  onTap: () {
                    router.pop(context);
                    router.navigateTo(context, '/shopping-list', transition: TransitionType.fadeIn);
                  },
                ),
                new ListTile(
                  title: new Text("Settings", style: TextStyle(color: currTextColor, fontSize: 17),),
                  leading: new Icon(Icons.settings, color: Colors.grey,),
                  onTap: () {
                    router.pop(context);
                    router.navigateTo(context, '/settings', transition: TransitionType.fadeIn);
                  },
                ),
              ],
            ),
            new Container(
              width: 250.0 - 16,
              child: new FlatButton(
                child: new Text("SIGN OUT", style: TextStyle(color: Colors.white),),
                color: Colors.red,
                onPressed: () {
                  AuthFunctions.signOut();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
