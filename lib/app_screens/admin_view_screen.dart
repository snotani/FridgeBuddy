import 'package:flutter/material.dart';
import 'admin_home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class admin_view_screen extends StatefulWidget {
  @override
  _admin_view_screenState createState() => new _admin_view_screenState();
}

class _admin_view_screenState extends State<admin_view_screen> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'User Update Screen',
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0), // here the desired height
          child: new AppBar(
            title: new Text("Update Fridge Items", style: TextStyle(fontSize: 40.0)),
            centerTitle: true,
            elevation: 10.0,
            leading: IconButton(
              icon: BackButton(color: Colors.white),
              onPressed: () {
                Navigator.pop(context,
                    MaterialPageRoute(builder: (context) => Admin_home_screen()));
              },
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 70.0,
          child: new BottomAppBar(
            color: Colors.blue,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.feedback, color: Colors.white),
                  iconSize: 50.0,
                  onPressed: () {
                    // add feedback page/alert - TBD
                    //feedbackDialog(context);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.settings, color: Colors.white),
                  iconSize: 50.0,
                  onPressed: () {
                    // add settings page/alert - TBD
                    //settingsDialog(context);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.help, color: Colors.white),
                  iconSize: 50.0,
                  onPressed: () {
                    // add help page/alert - TBD
                    //helpDialog(context);
                  },
                ),
              ],
            ),
          ),
        ),
        body: StreamBuilder(
            stream: Firestore.instance.collection('Items').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return new Text('Loading...');
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                ),
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) =>
                    _buildListItem(context, snapshot.data.documents[index]),
              );
            }),
      ),
    );
  }
}

Widget _buildListItem(BuildContext context, DocumentSnapshot document) {

  int quantity_check = 0;

  return ListTile(
    title: Row(
      children: [
        Expanded(
          child: Text(
            document['Item name'],
            style: Theme.of(context).textTheme.headline,
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Color(0xffddddff),
          ),
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.only(top: 15.0),
          child: Text(
            document['Quantity'].toString(),
            style: Theme.of(context).textTheme.display1,
          ),
        ),
      ],
    ),
    leading: new Icon(
      Icons.fastfood,
      size: 40.0,
      color: Colors.blue[700],
    ),
    subtitle: new Text(
      document['Donator'],
      style: Theme.of(context).textTheme.subhead,
    ),
  );
}

