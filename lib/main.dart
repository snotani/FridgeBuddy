import 'package:flutter/material.dart';
import './app_screens/user_update_screen.dart';
import 'package:flutter/services.dart';


void main(){
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "FridgeBuddy",
        home: user_update_screen(),
        theme: ThemeData(
          primaryColor: Colors.blue,
          accentColor: Colors.blueAccent,
          brightness: Brightness.dark,
        ),
      )
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
}
