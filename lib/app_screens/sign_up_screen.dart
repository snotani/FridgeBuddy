import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'admin_login_screen.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
String username;
String name;
String password;
var usernameController = new TextEditingController();
var nameController = new TextEditingController();
var passwordController = new TextEditingController();

//Handle sign up
Future<FirebaseUser> handleSignUp(email, password) async {
  final FirebaseUser user = await auth.createUserWithEmailAndPassword(email: email, password: password);
  assert (user != null);
  assert (await user.getIdToken() != null);
  await Firestore.instance
      .runTransaction((transaction) async {
    await transaction.set(
        Firestore.instance
            .collection("users")
            .document(user.uid),
        {
          'name': name,
          'email': user.email,
          'role': "user",
          'uid': user.uid
        });
  });
  return user;
  }

class sign_up_screen extends StatefulWidget {
  @override
  _sign_up_screenState createState() => _sign_up_screenState();
}

class _sign_up_screenState extends State<sign_up_screen> {
  // adding Var that will be used in the drop down menu

//the first text for the title admin login also the Appbar also
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text("FridgeBuddy Volunteer Sign Up")),
      body: Container(
        margin: EdgeInsets.only(top: 40.0),
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                "Admin Sign Up",
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 50.0),
              ),
            ),

            //Row which has the name text and text field
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 35.0,
                      left: 100.0,
                    ),
                    child: Text(
                      "Name",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontSize: 40.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 35.0, right: 50.0),
                      child: TextField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: "Name",
                            hintText: "John Smith",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        onChanged: (String labelText) {
                          name = labelText;
                        },
                      ),
                    ))
              ],
            ),

            //Row which has the username text and text field
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 35.0,
                      left: 100.0,
                    ),
                    child: Text(
                      "Email",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontSize: 40.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 35.0, right: 50.0),
                      child: TextField(
                        controller: usernameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: "Email",
                            hintText: "example@google.com",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        onChanged: (String labelText) {
                          username = labelText;
                        },
                      ),
                    ))
              ],
            ),

            //Row which has the password text and the text field
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 35.0,
                      left: 100.0,
                    ),
                    child: Text(
                      "Password",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontSize: 40.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 35.0, right: 50.0),
                      child: TextField(
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: "Password",
                            hintText: "",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        onChanged: (String labelText) {
                          password = labelText;
                        },
                      ),
                    ))
              ],
            ),
            //log in button
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Button_Login(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

//holds sign up button
class Button_Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            // Sign up button
            new MaterialButton(
                minWidth: 200,
                height: 50,
                color: Colors.green,
                child: Text(
                  "Sign Up",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(color: Colors.black, fontSize: 40.0),
                ),
                onPressed: () {
                  // Run sign up function
                  handleSignUp(username, password)
                      .then((FirebaseUser user) {
                    // Show alert box
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: new Text("Please wait for verification"),
                          content: new Text("Your account must be verified by an admin before you can sign in. Please wait for verification."),
                          actions: <Widget>[
                            // Close button on alert box
                            new FlatButton(
                              child: new Text("OK"),
                              onPressed: () {
                                usernameController.clear();
                                nameController.clear();
                                passwordController.clear();
                                username = "";
                                name = "";
                                password = "";
                                Navigator.of(context).pop();
                                Navigator.push(context, new MaterialPageRoute(builder: (context) => new login_screen()));
                              },
                            ),
                          ],
                        );
                      },
                    );
                    // print error
                  }).catchError((e) => print(e));
                }),
          ]
        )
    );
  }

}

