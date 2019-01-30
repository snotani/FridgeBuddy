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
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30.0, right: 50.0),
                          child: Text(
                              "Update Fridge Items",
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                fontSize: 50.0,
                              ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: add_icon_asset(),
                      ),
                    ]
                  ),
              ]
            ),
        ),
     ),
    );
  }
}

//widget that holds the image and returns it in a container
class add_icon_asset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //creating an object that passes that image/logo as a parameter

    AssetImage assetImage = AssetImage("images/add_icon.png");
    //create an image object from the assetimage object and pass it as parameter
    //resize the image with set heights and width

    Image add_icon_image = Image(
      image: assetImage,
      width: 70.0,
      height: 70.0,
    );

    //the method will return the logo image as a container
    // with in it will be a child that will hold the image
    return Container(
      child: add_icon_image,
    );
  }
}