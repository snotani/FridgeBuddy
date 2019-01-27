import 'package:flutter/material.dart';
import './mainView.dart';

class LoadScreen extends StatelessWidget{

  Widget build(BuildContext context) {
    return new Material(
      color: Colors.blueGrey,
      child: new InkWell(
        onTap: ()=> Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new MainView())),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("FridgeBuddy", style: new TextStyle(color: Colors.white, fontSize: 60.0, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}