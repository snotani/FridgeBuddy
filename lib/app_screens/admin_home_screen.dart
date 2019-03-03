import 'package:flutter/material.dart';
import 'admin_login_screen.dart';
import 'admin_update_screen.dart';
import 'admin_view_screen.dart';
import 'add_screen.dart';
import 'verify_accounts_screen.dart';


class Admin_home_screen extends StatefulWidget {
  @override
  _Admin_home_screenState createState() => _Admin_home_screenState();
}

class _Admin_home_screenState extends State<Admin_home_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          title: Text("Admin HomePage"),
          leading: IconButton(icon: Icon(
              Icons.exit_to_app),
              onPressed: () {
                log_out_alert(context);
              }
          )
      ),
      body: Container(
        margin: EdgeInsets.only(top: 40.0),
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                "FridgeBuddy Admin Home", textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 50.0),
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
                Button_verify()
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
        width: 450.0,
        height: 80.0,
        child: OutlineButton(
          color: Colors.green,
          child: Text(
            "Add Item",
            textDirection: TextDirection.ltr,
            style: TextStyle(color: Colors.green, fontSize: 40.0),
          ),
          onPressed: () {
            //action will go here for the next screen
            goToAddScreen(context);
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)),
          borderSide: BorderSide(color: Colors.green,width: 5.0),),
      ),
    );
  }
}

class Button_view extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Container(
        width: 450.0,
        height: 80.0,
        child: OutlineButton(
          color: Colors.amber,
          child: Text(
            "View Items",
            textDirection: TextDirection.ltr,
            style: TextStyle(color: Colors.amber, fontSize: 40.0),
          ),
          onPressed: () {
            goToViewScreen(context);
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)),
          borderSide: BorderSide(color: Colors.amber,width: 5.0),),
      ),
    );
  }
}

class Button_update extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Container(
        width: 450.0,
        height: 80.0,
        child: OutlineButton(
          color: Colors.orangeAccent,
          child: Text(
            "Update list",
            textDirection: TextDirection.ltr,
            style: TextStyle(color: Colors.orange, fontSize: 40.0),
          ),
          onPressed: () {
            goToUpdateScreen(context);
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)),
          borderSide: BorderSide(color: Colors.orange,width: 5.0),),
      ),
    );
  }
}

class Button_LogOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Container(
        width: 250.0,
        height: 80.0,
        child: OutlineButton(
          color: Colors.redAccent,
          child: Text(
            "Log Out",
            textDirection: TextDirection.ltr,
            style: TextStyle(color: Colors.red, fontSize: 40.0),
          ),
          onPressed: () {
            log_out_alert(context);
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)),
          borderSide: BorderSide(color: Colors.red,width: 5.0),),
      ),
    );
  }
}

class Button_verify extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Container(
        width: 450.0,
        height: 80.0,
        child: OutlineButton(
          color: Colors.blue,
          child: Text(
            "Verify users",
            textDirection: TextDirection.ltr,
            style: TextStyle(color: Colors.blue, fontSize: 40.0),
          ),
          onPressed: () {
            goToVerifyScreen(context);
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)),
          borderSide: BorderSide(color: Colors.blue,width: 5.0),),
      ),
    );
  }
}

void log_out_alert(BuildContext context) {
  var alertDialog = AlertDialog(
    title: Text("LogOut"),
    content: Text("Do you wish to log out?"),
    actions: <Widget>[
      FlatButton(child: Text("Yes"),
        onPressed: () {
          logging_out(context);
        },
      ),
      FlatButton(child: Text("No"),
        onPressed: () {
          leave_alert(context);
        },
      )
    ],
  );

  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      }
  );
}

void logging_out(BuildContext context) {
//action will go to the login screen or user homepage
  Navigator.pop(context);
  Navigator.pop(context);
}

void leave_alert(BuildContext context) {
  //action used to leave the alert
  Navigator.pop(context);
}

void goToAddScreen(context){
  getItems();
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => add_screen()));
}

void goToUpdateScreen(context){
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => admin_update_screen()));
}

void goToViewScreen(context){
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => admin_view_screen()));
}

void goToVerifyScreen(context){
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => verify_accounts_screen()));
}