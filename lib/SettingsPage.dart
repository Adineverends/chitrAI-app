import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

void main() => runApp (MyApp());

class MyApp extends StatelessWidget {

@override Widget build(BuildContext context) {

return CupertinoApp(

debugShowCheckedModeBanner: false, home: SettingsPage(), );

ار }

class SettingsPage extends StatefulWidget {

@override

SettingsPageState createState() => SettingsPageState(); }

class SettingsPageState extends State<SettingsPage> {

bool isPushNotificationEnabled = true;

bool isDarkModeEnabled false;

bool isLocationEnabled = false;

String username 'John Doe';

String email = 'john.doe@example.com';

@override

Widget build(BuildContext context) { return CupertinoPageScaffold(

navigationBar: CupertinoNavigationBar( middle: Text('Settings'),

), child: SafeArea(

child: ListView( children: [ // Profile Section padding: const EdgeInsets.all(16.0),

Padding(
