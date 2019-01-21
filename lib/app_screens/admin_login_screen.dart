import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: Text("Admin Login")
      ),
      body: Container(
        margin: EdgeInsets.only(top: 40.0),
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                  "Admin Login", textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: 50.0
                ),
              ),
            ),
           Row(
             children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.only(left: 230.0, top: 20.0),
                     child: logo_image_asset(),
                   ),
             ],
           ),

            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 35.0,
                      left: 100.0,
                    ),
                    child: Text(
                      "Username",
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
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: "Username",
                            hintText: "example@google.com",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ))
              ],
            ),

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
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: "Password",
                            hintText: "",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ))
              ],
            ),
            Column(
              children: <Widget>[Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Button_Login(),
              )],
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

    Image logo_image = Image(image: assetImage,width: 300.0, height: 300.0,);

    //the method will return the logo image as a container
    // with in it will be a child that will hold the image
    return Container(child: logo_image,);
  }
}
class Button_Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Container(
        width: 300.0,
        height: 100.0,
        child: RaisedButton(
            color: Colors.green,
            child: Text(
              "Log In",
              textDirection: TextDirection.ltr,
              style: TextStyle(color: Colors.black, fontSize: 40.0),
            ),
            elevation: 6.0,
            onPressed: () {


            }),
      ),
    );
  }
}

