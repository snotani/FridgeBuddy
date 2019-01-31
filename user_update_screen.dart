import 'package:flutter/material.dart';
import 'admin_login_screen.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';


class user_update_screen extends StatefulWidget {
  @override
  _user_update_screen createState() => _user_update_screen();
}

class _user_update_screen extends State<user_update_screen> {

  List<int> items = new List();

  @override
  void initState() {
    // for loop to add the amount of items to the fridge - link to database
    for (int i=0; i<50; i++){
      items.add(i);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'User Update Screen',
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Update Fridge Items"),
          centerTitle: true,
          elevation: 20.0,
          actions:  <Widget> [
            IconButton(
              tooltip: 'Admin Login',
              icon: const Icon(Icons.person_add),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> login_screen()));
              },
            ),
          ],
        ),
        body: new ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index){
              return new ListTile(
                title: new Text('Item no $index'),
                trailing: new Icon(Icons.arrow_drop_down)
              );
            }
        ),
      ),
    );
  }
}

//widget that holds the image and returns it in a container
/*class admin_icon_asset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //create an image object from the assetimage object and pass it as parameter
    AssetImage assetImage = AssetImage("images/add_icon.png");

    Image admin_icon_image = Image(
      image: assetImage,
      width: 70.0,
      height: 70.0,
    );

    //the method will return the logo image as a container
    // with in it will be a child that will hold the image
    return Container(
      child: admin_icon_image,
    );
  }
}*/