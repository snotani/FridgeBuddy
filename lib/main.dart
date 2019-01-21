import 'package:flutter/material.dart';
import './app_screens/add_screen.dart';

void main(){
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "FridgeBuddy",
        home: add_screen() ,
      )
  );
}