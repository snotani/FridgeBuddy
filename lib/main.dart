import 'package:flutter/material.dart';
import './app_screens/add_screen.dart';
import './app_screens/admin_login_screen.dart';

void main(){
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "FridgeBuddy",
        home: login_screen() ,
      )
  );
}