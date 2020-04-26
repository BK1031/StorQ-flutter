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
                new ClipRRect(borderRadius: BorderRadius.all(Radius.circular(75)), child: new Image.network("https://scontent-sjc3-1.xx.fbcdn.net/v/t1.0-9/93840601_229248548310154_5658292586943610880_o.jpg?_nc_cat=103&_nc_sid=85a577&_nc_ohc=MZAf-KKxMFQAX8glicd&_nc_ht=scontent-sjc3-1.xx&oh=80b37c15a2c4877b372ef9a0e3eb059e&oe=5EC9A6EE", width: 125, height: 125,)),
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
                  title: new Text("Report COVID-19", style: TextStyle(color: currTextColor, fontSize: 17),),
                  leading: new Icon(Icons.bug_report, color: Colors.grey,),
                  onTap: () {
                    showDialog(context: context, child: new AlertDialog(
                      title: new Text("Report COVID-19 Exposure"),
                      backgroundColor: currCardColor,
                      content: new Text("Please confirm below if you or someone you are in daily contact with has tested positive for Coronavirus (COVID-19). This way, we will be able to notify the shoppers who were present at the same stores and times as you."),
                      actions: <Widget>[
                        new FlatButton(onPressed: () => router.pop(context), child: new Text("CANCEL")),
                        new FlatButton(
                          child: new Text("CONFIRM"),
                          onPressed: () {
                            router.pop(context);
                          },
                        )
                      ],
                    ));
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
