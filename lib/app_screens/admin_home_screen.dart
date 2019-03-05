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
          leading: IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                log_out_alert(context);
              })),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height/17.5,
        child: new BottomAppBar(
          color: Colors.blue,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.feedback, color: Colors.white),
                iconSize: MediaQuery.of(context).size.height/23.5,
                onPressed: () {
                  feedbackDialog(context);
                },
              ),
              IconButton(
                icon: Icon(Icons.insert_chart, color: Colors.white),
                iconSize: MediaQuery.of(context).size.height/23.5,
                onPressed: () {
                  // add analytics- TBD
                  statisticsDialog(context);
                },
              ),
              IconButton(
                icon: Icon(Icons.help, color: Colors.white),
                iconSize: MediaQuery.of(context).size.height/23.5,
                onPressed: () {
                  helpDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 30),
        child: ListView(
          children: <Widget>[
            Center(
              child: Text(
                "FridgeBuddy Admin Home",style: TextStyle(fontSize: MediaQuery.of(context).size.width / 14),
                textDirection: TextDirection.ltr,
              ),
            ),
            Column(
              children: <Widget>[Button_view()],
            ),
            Column(
              children: <Widget>[Button_add()],
            ),
            Column(
              children: <Widget>[Button_update()],
            ),
            Column(
              children: <Widget>[Button_verify()],
            ),
            Column(
              children: <Widget>[Button_LogOut()],
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
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 25),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5 ,
        height: MediaQuery.of(context).size.height / 16 ,
        child: OutlineButton(
          color: Colors.green,
          child: Text(
            "Add Item",
            textDirection: TextDirection.ltr,
            style: TextStyle(color: Colors.green,fontSize: MediaQuery.of(context).size.width / 18),
          ),
          onPressed: () {
            //action will go here for the next screen
            goToAddScreen(context);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          borderSide: BorderSide(color: Colors.green, width: 5.0),
        ),
      ),
    );
  }
}

class Button_view extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 25),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5 ,
        height: MediaQuery.of(context).size.height / 16 ,
        child: OutlineButton(
          color: Colors.amber,
          child: Text(
            "View Items",
            textDirection: TextDirection.ltr,
            style: TextStyle(color: Colors.amber,fontSize: MediaQuery.of(context).size.width / 18),
          ),
          onPressed: () {
            goToViewScreen(context);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          borderSide: BorderSide(color: Colors.amber, width: 5.0),
        ),
      ),
    );
  }
}

class Button_update extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 25),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5 ,
        height: MediaQuery.of(context).size.height / 16 ,
        child: OutlineButton(
          color: Colors.orangeAccent,
          child: Text(
            "Update list",
            textDirection: TextDirection.ltr,
            style: TextStyle(color: Colors.orange,fontSize: MediaQuery.of(context).size.width / 18),
          ),
          onPressed: () {
            goToUpdateScreen(context);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          borderSide: BorderSide(color: Colors.orange, width: 5.0),
        ),
      ),
    );
  }
}

class Button_LogOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4.5),
      child: Container(
        width: MediaQuery.of(context).size.width / 2 ,
        height: MediaQuery.of(context).size.height / 16 ,
        child: OutlineButton(
          color: Colors.redAccent,
          child: Text(
            "Log Out",
            textDirection: TextDirection.ltr,
            style: TextStyle(color: Colors.red,fontSize: MediaQuery.of(context).size.width / 18),
          ),
          onPressed: () {
            log_out_alert(context);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          borderSide: BorderSide(color: Colors.red, width: 5.0),
        ),
      ),
    );
  }
}

class Button_verify extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 25),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height / 16,
        child: OutlineButton(
          color: Colors.blue,
          child: Text(
            "Verify users",
            textDirection: TextDirection.ltr,
            style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).size.width / 18),
          ),
          onPressed: () {
            getCurrentUser();
            goToVerifyScreen(context);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          borderSide: BorderSide(color: Colors.blue, width: 5.0),
        ),
      ),
    );
  }
}

void feedbackDialog(BuildContext context) {
  var alertDialog = AlertDialog(
    title: new Text("Feedback"),
    content: new Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(hintText: 'Enter feedback here...'),
          onChanged: (value) {

          },
        ),
        SizedBox(height: 10.0,)
      ],
    ),

  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      });
}

void statisticsDialog(BuildContext context) {
  var alertDialog = AlertDialog(
    title: new Text("Statistics"),
    content: new Text("Add statistics page here - Pull data of analytics from Firebase"),
  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      });
}

void helpDialog(BuildContext context) {
  var alertDialog = AlertDialog(
    title: Text("Help"),
    content: Text("FridgeBuddy is a project where we aim to reduce food wastage in the university. "
        "The project would do this by helping both staff and students monitor the contents of the Community Fridge. "
        "This will also include statistics about the Community Fridge usage to reduce even more food waste within the University.",
        style: TextStyle(height: 2.0)),
  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      });
}

void log_out_alert(BuildContext context) {
  var alertDialog = AlertDialog(
    title: Text("LogOut"),
    content: Text("Do you wish to log out?"),
    actions: <Widget>[
      FlatButton(
        child: Text("Yes"),
        onPressed: () {
          logging_out(context);
        },
      ),
      FlatButton(
        child: Text("No"),
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
      });
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

void goToAddScreen(context) {
  try {
    getItems();
    getFridges();
    getShops();
  } finally {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => add_screen()));
  }
}

void goToUpdateScreen(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => admin_update_screen()));
}

void goToViewScreen(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => admin_view_screen()));
}

void goToVerifyScreen(context) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => verify_accounts_screen()));
}
