import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:project_malai/screens/home/home_page.dart';
import 'package:project_malai/screens/settings/settings_page.dart';
import 'package:project_malai/screens/shopping/shopping_list_page.dart';
import 'package:project_malai/screens/shopping/shopping_store_detail_page.dart';
import 'package:project_malai/screens/shopping/shopping_store_page.dart';
import 'package:project_malai/screens/startup/auth_checker.dart';
import 'package:project_malai/screens/startup/network_checker.dart';
import 'package:project_malai/screens/startup/onboarding.dart';
import 'package:project_malai/theme.dart';
import 'config.dart';

void main() {

  // STARTUP ROUTES
  router.define('/check-connection', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new NetworkChecker();
  }));
  router.define('/onboarding', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new OnboardingPage();
  }));
  router.define('/check-auth', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new AuthChecker();
  }));

  router.define('/home', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new HomePage();
  }));

  router.define('/shopping-list', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new ShoppingListPage();
  }));
  router.define('/shopping-store', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new ShoppingStorePage();
  }));
  router.define('/shopping-store/details', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new ShoppingStoreDetailPage();
  }));

  router.define('/settings', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new SettingsPage();
  }));

  runApp(new MaterialApp(
    title: "Project Malai",
    home: NetworkChecker(),
    onGenerateRoute: router.generator,
    navigatorObservers: <NavigatorObserver>[routeObserver],
    debugShowCheckedModeBanner: false,
    theme: mainTheme,
  ));
}