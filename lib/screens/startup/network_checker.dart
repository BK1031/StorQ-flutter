import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../../config.dart';

class NetworkChecker extends StatefulWidget {
  @override
  _NetworkCheckerState createState() => _NetworkCheckerState();
}

class _NetworkCheckerState extends State<NetworkChecker> {

  final connectionRef = FirebaseDatabase.instance.reference().child(".info/connected");

  Future<void> checkConnection() async {
    connectionRef.onValue.listen(connectionListener);
  }

  connectionListener(Event event) {
    print(event.snapshot.value);
    if (event.snapshot.value) {
      print("Connected");
      if (FirebaseAuth.instance.currentUser() != null) {
        // User logged!
        // TODO: get user info and populate user object from firebase
        router.navigateTo(context, '/home', transition: TransitionType.fadeIn, replace: true);
      }
      else {
        router.navigateTo(context, '/onboarding', transition: TransitionType.fadeIn, replace: true);
      }
    }
    else {
      print("Not Connected");
      router.navigateTo(context, '/check-connection', transition: TransitionType.fadeIn, replace: true);
    }
  }

  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        child: new Center(
          child: new Text("Connecting..."),
        ),
      ),
    );
  }
}
