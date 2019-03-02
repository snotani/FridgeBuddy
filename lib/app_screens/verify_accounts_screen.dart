import 'package:flutter/material.dart';
import 'admin_home_screen.dart';
import 'admin_update_screen.dart';
import 'add_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class verify_accounts_screen extends StatefulWidget {
  @override
  _verify_accounts_screenState createState() => _verify_accounts_screenState();
}

class _verify_accounts_screenState extends State<verify_accounts_screen> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0), // here the desired height
        child: new AppBar(
          title: new Text("Verify Users", style: TextStyle(fontSize: 40.0)),
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

      body: StreamBuilder(
          stream: Firestore.instance.collection('users').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return new Text('Loading...');

            return ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Colors.black,
              ),
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) =>
                  _buildListItem(context, snapshot.data.documents[index], false),
            );
          }),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document, bool oldValue){
    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: Text(
              document['name'],
              style: Theme.of(context).textTheme.headline,
            ),
          ),

          Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.only(top: 15.0),
            child: Text(
              document['role'].toString(),
              style: Theme.of(context).textTheme.headline,
            ),
          ),
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.adjust),
        iconSize: 50.0,
        color: Colors.green[700],
        onPressed: () {
          if(document['role'] == "admin"){
            Firestore.instance
                .runTransaction((transaction) async {
              await transaction.update(
                  Firestore.instance
                      .collection("users")
                      .document(document['uid']),
                  {
                    'role': "user",
                  });
            });
          } else if(document['role'] == "user"){
            Firestore.instance
                .runTransaction((transaction) async {
              await transaction.update(
                  Firestore.instance
                      .collection("users")
                      .document(document['uid']),
                  {
                    'role': "admin",
                  });
            });
          }
        }),
      subtitle: new Text(
        document['email'],
        style: Theme.of(context).textTheme.subhead,
      ),
    );



  }


}

