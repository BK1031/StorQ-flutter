import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_malai/user_info.dart';

import '../../config.dart';
import '../../theme.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {

  String password = "";
  bool registered = false;

  final databaseRef = FirebaseDatabase.instance.reference();

  Future<void> register() async {
    AuthResult user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    print("Signed in! ${user.user.uid}");
    // Define Initial Database Values
    userID = user.user.uid;
    databaseRef.child("users").child(userID).update({
      "name": name,
      "email": email,
      "darkMode": darkMode,
      "profilePicUrl": profilePic
    });
    setState(() {
      registered = true;
    });
    await Future.delayed(const Duration(milliseconds: 300));
    router.navigateTo(context, '/home', transition: TransitionType.fadeIn, clearStack: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: new AppBar(
//        title: new Text("Welcome"),
//      ),
      body: new SafeArea(
        child: new Container(
          padding: EdgeInsets.all(8.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Visibility(
                visible: name == "",
                child: new Text(
                  "Welcome to Itemyze",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              new Padding(padding: EdgeInsets.all(8)),
              new Visibility(
                visible: name == "",
                child: new TextField(
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  decoration: InputDecoration.collapsed(
                    hintText: "What should we call you?"
                  ),
                  onSubmitted: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                ),
              ),
              new Padding(padding: EdgeInsets.all(8)),
              new Visibility(
                visible: name != "",
                child: new Text(
                  "Hey ${name.split(" ")[0]}!",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              new Padding(padding: EdgeInsets.all(8)),
              new Visibility(
                visible: name != "",
                child: new TextField(
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  decoration: InputDecoration.collapsed(
                      hintText: "What is your email?"
                  ),
                  onSubmitted: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),
              ),
              new Padding(padding: EdgeInsets.all(8)),
              new Visibility(
                visible: email != "",
                child: new Text(
                  "Perfect!",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              new Padding(padding: EdgeInsets.all(8)),
              new Visibility(
                visible: email != "",
                child: new TextField(
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  obscureText: true,
                  decoration: InputDecoration.collapsed(
                      hintText: "Please create a password",
                  ),
                  onSubmitted: (val) {
                    setState(() {
                      password = val;
                    });
                    register();
                  },
                ),
              ),
              new Padding(padding: EdgeInsets.all(8)),
              new Visibility(
                visible: registered,
                child: new Text(
                  "You're all set!",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
