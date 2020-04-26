import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../theme.dart';
import '../../user_info.dart';

class AuthFunctions {
  static Future<bool> getUserData() async {
    bool returnValue = false;
    await FirebaseDatabase.instance.reference().child("users").child(userID).once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        var userInfo = snapshot.value;
        email = userInfo["email"];
        name = userInfo["name"];
        darkMode = userInfo["darkMode"];
        profilePic = userInfo["profilePicUrl"];
        print("");
        print("------------ USER DEBUG INFO ------------");
        print("NAME: $name");
        print("EMAIL: $email");
        print("USERID: $userID");
        print("-----------------------------------------");
        print("");
        if (email == null || name == null) {
          returnValue = false;
        }
        else {
          returnValue = true;
        }
      }
      else {
        returnValue = false;
      }
    });
    return returnValue;
  }

  static Future<bool> signOut() async {
    bool returnValue = false;
    try {
      FirebaseAuth.instance.signOut();
      returnValue = true;
      name = "";
      email = "";
      userID = "";
      darkMode = false;
      profilePic = "https://firebasestorage.googleapis.com/v0/b/vc-deca.appspot.com/o/default.png?alt=media&token=a38584fb-c774-4f75-99ab-71b120c87df1";
      FirebaseAuth.instance.signOut();
    } catch (err) {
      print("Error Signing Out: $err");
      returnValue = false;
    }
    return returnValue;
  }
}