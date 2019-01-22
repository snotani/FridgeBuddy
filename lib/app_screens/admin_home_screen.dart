import 'package:flutter/material.dart';
import 'admin_login_screen.dart';
import 'add_screen.dart';


class Admin_home_screen extends StatefulWidget {
  @override
  _Admin_home_screenState createState() => _Admin_home_screenState();
}

class _Admin_home_screenState extends State<Admin_home_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin HomePage")),
      body: Container(
        margin: EdgeInsets.only(top: 40.0),
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                  "FridgeBuddy Admin Home", textDirection: TextDirection.ltr,
                style:TextStyle(fontSize: 50.0) ,
              ),
            ),
            Column(
            children: <Widget>[
                Button_view()
              ],
            ),
            Column(
            children: <Widget>[
            Button_add()
             ],
            ),
            Column(
            children: <Widget>[
              Button_update()
              ],
             ),
            Column(
            children: <Widget>[
              Button_LogOut()
            ],
            )

          ],
        ),
      ),
    );
  }
}

class Button_add extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Container(
        width: 600.0,
        height: 100.0,
        child: RaisedButton(
            color: Colors.green,
            child: Text(
              "Add Item",
              textDirection: TextDirection.ltr,
              style: TextStyle(color: Colors.black, fontSize: 40.0),
            ),
            elevation: 6.0,
            onPressed: () {
              //action will go here for the next screen
              Navigator.push(context, new MaterialPageRoute(builder: (context)=> add_screen()));
            }),
      ),
    );
  }
}

class Button_view  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Container(
        width: 300.0,
        height: 100.0,
        child: RaisedButton(
            color: Colors.amber,
            child: Text(
              "View Items",
              textDirection: TextDirection.ltr,
              style: TextStyle(color: Colors.black, fontSize: 40.0),
            ),
            elevation: 6.0,
            onPressed: () {
              //action will go to the items list page

            }),
      ),
    );
  }
}

class Button_update  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Container(
        width: 600.0,
        height: 100.0,
        child: RaisedButton(
            color: Colors.orangeAccent,
            child: Text(
              "Update list",
              textDirection: TextDirection.ltr,
              style: TextStyle(color: Colors.black, fontSize: 40.0),
            ),
            elevation: 6.0,
            onPressed: () {
              //action will go to the list of itemspage

            }),
      ),
    );
  }
}

class Button_LogOut  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 150.0),
      child: Container(
        width: 300.0,
        height: 100.0,
        child: RaisedButton(
            color: Colors.redAccent,
            child: Text(
              "Log Out",
              textDirection: TextDirection.ltr,
              style: TextStyle(color: Colors.black, fontSize: 40.0),
            ),
            elevation: 6.0,
            onPressed: () {
              //action will go to the login screen or user homepage
              Navigator.push(context, new MaterialPageRoute(builder: (context)=> login_screen()));
            }),
      ),
    );
  }
}