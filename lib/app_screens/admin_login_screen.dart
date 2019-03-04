import 'package:flutter/material.dart';
import 'admin_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'sign_up_screen.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
String username;
String password;
var usernameController = new TextEditingController();
var passwordController = new TextEditingController();

//Handle sign in
Future<FirebaseUser> handleSignInEmail(String email, String password) async {
  final FirebaseUser user = await auth.signInWithEmailAndPassword(email: email, password: password);
  assert(user != null);
  assert(await user.getIdToken() != null);
  final FirebaseUser currentUser = await auth.currentUser();
  assert(user.uid == currentUser.uid);
  print('signInEmail succeeded: $user');
  return user;
}

class login_screen extends StatefulWidget {
  @override
  _login_screenState createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  // adding Var that will be used in the drop down menu

//the first text for the title admin login also the Appbar also
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text("Admin Login")),
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                "Admin Login",
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 50.0),
              ),
            ),

            //Row widget which has the image
            Row(
              children: <Widget>[
                Expanded(
                child: logo_image_asset()
                )
              ],
            ),

            //Row which has the username text and text field
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04,),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.13),
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
                        padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.13),
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
            ),

            //Row which has the password text and the text field
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01, left: MediaQuery.of(context).size.width * 0.13),
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
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01, right: MediaQuery.of(context).size.width * 0.13),
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
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
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

//widget that holds the image and returns it in a container
class logo_image_asset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //creating an object that passes that image/logo as a parameter

    AssetImage assetImage = AssetImage("images/logo.png");
    //create an image object from the assetimage object and pass it as parameter
    //resize the image with set heights and width

    Image logo_image = Image(
      image: assetImage,
      width: MediaQuery.of(context).size.width / 4 ,
      height: MediaQuery.of(context).size.height / 3.5,
    );

    //the method will return the logo image as a container
    // with in it will be a child that will hold the image
    return Container(
      child: logo_image,
    );
  }
}

//holds both the login and sign up button
class Button_Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // The sign in button
            new MaterialButton(
              minWidth: MediaQuery.of(context).size.width * 0.30 ,
              height:  MediaQuery.of(context).size.height * 0.04,
              color: Colors.green,
              child: Text(
                "Sign In",
                textDirection: TextDirection.ltr,
                style: TextStyle(color: Colors.black, fontSize: 40.0),
              ),
              onPressed: () {
                // Run sign in function
                handleSignInEmail(username, password)
                    // Clear fields
                    .then((FirebaseUser user) {
                      // Go to admin page
                      authorizeAccess(context);
                }).catchError((e) => print(e));
              }),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            // Sign up button
            new MaterialButton(
                minWidth: MediaQuery.of(context).size.width * 0.30 ,
                height:  MediaQuery.of(context).size.height * 0.04,
                color: Colors.green,
                child: Text(
                  "Sign Up",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(color: Colors.black, fontSize: 40.0),
                ),
                onPressed: () {
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => new sign_up_screen()));
                }),
          ]
        )
    );
  }

  authorizeAccess(BuildContext context){
    FirebaseAuth.instance.currentUser().then((user){
      Firestore.instance.collection('/users').where('uid', isEqualTo: user.uid).getDocuments().then((docs){
        if(docs.documents[0].exists){
          if(docs.documents[0].data['role'] == 'admin'){
            usernameController.clear();
            passwordController.clear();
            username = "";
            password = "";
            Navigator.push(context, new MaterialPageRoute(builder: (context) => new Admin_home_screen()));
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: new Text("Not verified"),
                  content: new Text("Your account has not been verified by an admin. Try again later."),
                  actions: <Widget>[
                    // Close button on alert box
                    new FlatButton(
                      child: new Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        }
      });
    });
  }
}

