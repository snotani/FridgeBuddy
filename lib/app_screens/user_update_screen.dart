import 'package:flutter/material.dart';
import 'admin_login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class user_update_screen extends StatefulWidget {
  @override
  _user_update_screen createState() => _user_update_screen();
}


class _user_update_screen extends State<user_update_screen> {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'User Update Screen',
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Update Fridge Items"),
          centerTitle: true,
          elevation: 10.0,
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
        bottomNavigationBar: Container(
          height: 55.0,
          child: new BottomAppBar(
            color: Colors.blue,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.feedback, color: Colors.white),
                  onPressed: () {
                    // add feedback page/alert
                    feedbackDialog(context);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.settings, color: Colors.white),
                  onPressed: () {
                    // add settings page/alert
                    settingsDialog(context);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.help, color: Colors.white),
                  onPressed: () {
                    // add help page/alert
                    helpDialog(context);
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
              return ListView.builder(
                itemExtent: 80.0,
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
    ),
    subtitle: new Text(
        'Brief description of the food item',
        style: Theme.of(context).textTheme.subhead,
    ),
    onTap: () {
      Firestore.instance.runTransaction((transaction) async {
        DocumentSnapshot freshSnap =
        await transaction.get(document.reference);
        await transaction.update(freshSnap.reference, {
          'Quantity': freshSnap['Quantity'] + 1,

        });
      });
    },
  );
}

void feedbackDialog(BuildContext context) {
  var alertDialog = AlertDialog(
    title: new Text("Feedback"),
    content: new Text("Please submit your feedback below:"),
    // add textfield
  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      });
}

void settingsDialog(BuildContext context) {
  var alertDialog = AlertDialog(
    title: new Text("Settings"),
    content: new Text("Add settings here"),
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
    content: Text("Explain how to use the app"),
  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      });
}
