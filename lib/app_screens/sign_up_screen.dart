import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'admin_login_screen.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
String emailAddress;
String name;
String password;
var emailController = new TextEditingController();
var nameController = new TextEditingController();
var passwordController = new TextEditingController();
var _signUpFormKey = GlobalKey<FormState>();

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

bool isEmail(String em) {

  String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(p);

  return regExp.hasMatch(em);
}

class sign_up_screen extends StatefulWidget {
  @override
  _sign_up_screenState createState() => _sign_up_screenState();
}

class _sign_up_screenState extends State<sign_up_screen> {

//the first text for the title admin login also the Appbar also
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Add Item"),
      ),
      body: Form(
        key: _signUpFormKey,
        child: Container(
        margin: EdgeInsets.only(top: 40.0),
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                "Volunteer Sign Up",
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
                      child: TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: "Name",
                            hintText: "John Smith",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        validator: (value){
                          if(value.length < 1 || value == null){
                            return ('Please enter a valid name');
                          }
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
                      child: new TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: "Email",
                            hintText: "example@google.com",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        validator: (value){
                          if(value.length < 1 || value == null || value.contains("@") == false || isEmail(value) == false){
                            return ('Please enter a valid email');
                          }
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
                      child: new TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: "Password",
                            hintText: "",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        validator: (value){
                          if(value.length < 1 || value == null){
                            return ('Please enter a valid password');
                          }
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
                  emailAddress = emailController.text;
                  name = nameController.text;
                  password = passwordController.text;
                  if(_signUpFormKey.currentState.validate()) {
                    // Run sign up function
                    handleSignUp(emailAddress, password)
                    .then((FirebaseUser user) {
                      // Show alert box
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: new Text("Please wait for verification"),
                              content: new Text(
                                  "Your account must be verified by an admin before you can sign in. Please wait for verification."),
                              actions: <Widget>[
                                // Close button on alert box
                                new FlatButton(
                                  child: new Text("OK"),
                                  onPressed: () {
                                    emailController.clear();
                                    nameController.clear();
                                    passwordController.clear();
                                    emailAddress = "";
                                    name = "";
                                    password = "";
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    },
                                ),
                              ],
                            );
                            },
                        );
                        // print error
                    }).catchError((e) => print(e));
                  }
                }),
          ]
        )
    );
  }

}

