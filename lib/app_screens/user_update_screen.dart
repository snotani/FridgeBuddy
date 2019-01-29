import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'admin_login_screen.dart';

class user_update_screen extends StatefulWidget {
  @override
  _user_update_screen createState() => _user_update_screen();
}

class _user_update_screen extends State<user_update_screen> {

  var _formKey = GlobalKey<FormState>();
  final TOP_PADDING = 40.0;
  final LEFT_PADDING = 50.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomPadding: false,
        appBar: AppBar(
        title: Text("Update Fridge Items"),
    ),
    body: Form(
     key: _formKey,
     child: Padding(
       padding: EdgeInsets.only(top: TOP_PADDING),
       child: ListView(
        children: <Widget>[
          Center(
            child: Text(
                "Update Fridge Items",
                textDirection: TextDirection.ltr,
                style: TextStyle(
                    fontSize: 50.0,
                ),
            ),
          ),
        ]
       ),
     ),
    ),
    );
  }
}