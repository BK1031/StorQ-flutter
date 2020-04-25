import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:project_malai/screens/home/home_page.dart';
import 'package:project_malai/screens/startup/network_checker.dart';
import 'package:project_malai/screens/startup/onboarding.dart';
import 'config.dart';

void main() {

  // STARTUP ROUTES
  router.define('/check-connection', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new NetworkChecker();
  }));
  router.define('/onboarding', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new OnboardingPage();
  }));
  router.define('/home', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new HomePage();
  }));

  runApp(new MaterialApp(
    title: "VC DECA",
    home: NetworkChecker(),
    onGenerateRoute: router.generator,
    navigatorObservers: <NavigatorObserver>[routeObserver],
    debugShowCheckedModeBanner: false,
    theme: mainTheme,
  ));
}