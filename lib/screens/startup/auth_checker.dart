import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config.dart';
import '../../theme.dart';
import '../../user_info.dart';
import 'auth_functions.dart';

class AuthChecker extends StatefulWidget {
  @override
  _AuthCheckerState createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {

  final databaseRef = FirebaseDatabase.instance.reference();

  Future checkAuth() async {
    var user = await FirebaseAuth.instance.currentUser();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (user != null) {
      // User logged
      print("User Logged");
      userID = user.uid;
      await AuthFunctions.getUserData().then((bool retrievedData) async {
        if (retrievedData) {
          print("Retrieved User Data");
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
          // A nice delay to make sure everything doesn't go to shit
          await Future.delayed(const Duration(milliseconds: 300));
          router.navigateTo(context, '/home', transition: TransitionType.fadeIn, clearStack: true);
        }
        else {
          print("Failed to Retrieve User Data");
          FirebaseAuth.instance.signOut();
          router.navigateTo(context, '/onboarding', transition: TransitionType.fadeIn, clearStack: true);
        }
      });
    }
    else {
      // User not logged
      print("User Not Logged");
      router.navigateTo(context, '/onboarding', transition: TransitionType.fadeIn, clearStack: true);
    }
  }

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: new Text("Loading..."),
      ),
    );
  }
}
