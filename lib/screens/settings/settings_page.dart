import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:project_malai/screens/startup/auth_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../app_drawer.dart';
import '../../config.dart';
import '../../theme.dart';
import '../../user_info.dart';
import 'package:fluro/fluro.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  void handleSignOut() async {
    if (Platform.isIOS) {
      showCupertinoModalPopup(context: context, builder: (BuildContext context) {
        return new CupertinoActionSheet(
//          title: new Text("Sign out"),
            message: new Text("Are you sure you want to sign out?"),
            actions: <Widget>[
              new CupertinoActionSheetAction(
                child: new Text("Sign out"),
                isDestructiveAction: true,
                onPressed: () async {
                  await AuthFunctions.signOut().then((response) {
                    if (response) {
                      router.navigateTo(context, '/onboarding', replace: true, clearStack: true, transition: TransitionType.fadeIn);
                    }
                    else {
                      // TODO: Add error alert
                    }
                  });
                },
              )
            ],
            cancelButton: new CupertinoActionSheetAction(
              child: const Text("Cancel"),
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
            )
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Settings"),
      ),
      drawer: new AppDrawer(),
      body: new Container(
        color: currBackgroundColor,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              new Card(
                elevation: 6.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                color: currCardColor,
                child: new Column(
                  children: <Widget>[
                    new Container(
                      padding: EdgeInsets.only(top: 16.0),
                      child: new Text(name.toUpperCase(), style: TextStyle(color: mainColor, fontSize: 18, fontFamily: "Product Sans", fontWeight: FontWeight.bold),),
                    ),
                    new ListTile(
                      title: new Text("Email", style: TextStyle(fontFamily: "Product Sans", color: currTextColor),),
                      trailing: new Text(email, style: TextStyle(fontSize: 16.0, fontFamily: "Product Sans", color: currTextColor)),
                    ),
                    new ListTile(
                      title: new Text("User ID", style: TextStyle(fontFamily: "Product Sans", color: currTextColor)),
                      trailing: new Text(userID, style: TextStyle(fontSize: 14.0, fontFamily: "Product Sans", color: currTextColor)),
                    ),
                    new ListTile(
                      title: new Text("Update Profile", style: TextStyle(fontFamily: "Product Sans", color: mainColor), textAlign: TextAlign.center,),
                      onTap: () {
                        router.navigateTo(context, '/settings/update-profile', transition: TransitionType.nativeModal);
                      },
                    )
                  ],
                ),
              ),
              new Padding(padding: EdgeInsets.all(4.0)),
              new Card(
                elevation: 6.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                color: currCardColor,
                child: Column(
                  children: <Widget>[
                    new Container(
                      padding: EdgeInsets.only(top: 16.0),
                      child: new Text("General".toUpperCase(), style: TextStyle(color: mainColor, fontSize: 18, fontFamily: "Product Sans", fontWeight: FontWeight.bold),),
                    ),
                    new ListTile(
                      title: new Text("About", style: TextStyle(fontFamily: "Product Sans", color: currTextColor)),
                      trailing: new Icon(Icons.arrow_forward_ios, color: mainColor),
                      onTap: () {
                        router.navigateTo(context, '/settings/about', transition: TransitionType.native);
                      },
                    ),
                    new ListTile(
                      title: new Text("Help", style: TextStyle(fontFamily: "Product Sans", color: currTextColor)),
                      trailing: new Icon(Icons.arrow_forward_ios, color: mainColor),
                      onTap: () async {
                        const url = 'https://github.com/BK1031/VC-DECA-flutter/wiki/Help';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    ),
                    new ListTile(
                      title: new Text("Sign Out", style: TextStyle(color: Colors.red, fontFamily: "Product Sans"),),
                      onTap: handleSignOut,
                    ),
                  ],
                ),
              ),
              new Padding(padding: EdgeInsets.all(4.0)),
              new Card(
                elevation: 6.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                color: currCardColor,
                child: Column(
                  children: <Widget>[
                    new Container(
                      padding: EdgeInsets.only(top: 16.0),
                      child: new Text("Preferences".toUpperCase(), style: TextStyle(color: mainColor, fontSize: 18, fontFamily: "Product Sans", fontWeight: FontWeight.bold),),
                    ),
                    new SwitchListTile.adaptive(
                      activeColor: mainColor,
                      activeTrackColor: mainColor,
                      title: new Text("Dark Mode", style: TextStyle(fontFamily: "Product Sans", color: currTextColor)),
                      value: darkMode,
                      onChanged: (bool value) {
                        // Toggle Dark Mode
                        setState(() {
                          darkMode = value;
                          if (darkMode) {
                            currTextColor = darkTextColor;
                            currBackgroundColor = darkBackgroundColor;
                            currCardColor = darkCardColor;
                            currDividerColor = darkDividerColor;
                          }
                          else {
                            currTextColor = lightTextColor;
                            currBackgroundColor = lightBackgroundColor;
                            currCardColor = lightCardColor;
                            currDividerColor = lightDividerColor;
                          }
                          FirebaseDatabase.instance.reference().child("users").child(userID).update({"darkMode": darkMode});
                        });
                      },
                    ),
                  ],
                ),
              ),
              new Padding(padding: EdgeInsets.all(4.0)),
              new Card(
                elevation: 6.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                color: currCardColor,
                child: Column(
                  children: <Widget>[
                    new Container(
                      padding: EdgeInsets.only(top: 16.0),
                      child: new Text("Feedback".toUpperCase(), style: TextStyle(color: mainColor, fontSize: 18, fontFamily: "Product Sans", fontWeight: FontWeight.bold),),
                    ),
                    new ListTile(
                      title: new Text("Provide Feedback", style: TextStyle(fontFamily: "Product Sans", color: currTextColor)),
                      trailing: new Icon(Icons.arrow_forward_ios, color: mainColor),
                      onTap: () async {
                        const url = 'https://github.com/equinox-initiative/project-malai-flutter/issues';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    ),
                    new ListTile(
                      title: new Text("Report a Bug", style: TextStyle(fontFamily: "Product Sans", color: currTextColor)),
                      trailing: new Icon(Icons.arrow_forward_ios, color: mainColor),
                      onTap: () async {
                        const url = 'https://github.com/equinox-initiative/project-malai-flutter/issues';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
