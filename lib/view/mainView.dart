import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fridgebuddymobile/objects/FridgeTile.dart';

class MainView extends StatefulWidget {

  @override
  State createState() => new MainWidgetState();

}
class MainWidgetState extends State<MainView> {

  List<Widget> _data = new List();
  Timer timer;

  Widget build(BuildContext context) {
    return Scaffold(
      // ...
      body: Center(
        child: new ListView(children: _data),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    timer = new Timer.periodic(new Duration(seconds: 2), (Timer timer) async {

      FridgeTile newTile = await loadData();

      this.setState(() {
        _data.insert(0, newTile);
        //_data.removeAt(index);
        _data = _data.toList();
        print(newTile);
      });

    });
  }

  Future<FridgeTile> loadData() async {
    testCount++;
    return new FridgeTile(title: "Testname #$testCount", expiry: "10/03/2019", location: "corner");
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  static int testCount = 0;
}