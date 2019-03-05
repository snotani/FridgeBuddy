import 'package:flutter/material.dart';
import 'admin_home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'admin_home_screen.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
String currentUserRole;

//Get current user's role
Future<FirebaseUser> getCurrentUser() async {
  final FirebaseUser currentUser = await auth.currentUser();
  Firestore.instance.collection('/users').where('uid', isEqualTo: currentUser.uid).getDocuments().then((docs){
    if(docs.documents[0].exists) {
      currentUserRole = docs.documents[0].data['role'].toString();
      print(currentUserRole);
      return currentUserRole;
    }
  });
}

class verify_accounts_screen extends StatefulWidget {
  @override
  _verify_accounts_screenState createState() => _verify_accounts_screenState();
}

class _verify_accounts_screenState extends State<verify_accounts_screen> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar:
        new AppBar(
          title: new Text("Verify Users", style:  TextStyle(fontSize: MediaQuery.of(context).size.width/20)),
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
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height/17.5,
        child: new BottomAppBar(
          color: Colors.blue,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                iconSize: MediaQuery.of(context).size.height/23.5,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      //Stream a list of each user present in the "users" collection
      body: StreamBuilder(
          stream: Firestore.instance.collection('users').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return new Text('Loading...');
            //Separate results
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Colors.black,
              ),
              itemCount: snapshot.data.documents.length,
              //For each document, build a new list item
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
              style: TextStyle(fontSize: MediaQuery.of(context).size.height / 40),
            ),
          ),

          Container(
            child: Text(
              document['role'].toString(),
              style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20),
            ),
          ),
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.adjust),
        iconSize: MediaQuery.of(context).size.width / 11,
        color: Colors.green[700],
        onPressed: () {
          //If user to change is admin, only another admin can change their role.
          if(document['role'] == "admin"){
            //If not an admin, cannot change role
            if(currentUserRole != "admin"){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: new Text("Not an admin"),
                    content: new Text("You cannot change the status of other admins."),
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
            } //If admin, can change role
            else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: new Text("Confirm role change"),
                      content: new Text(
                          "Change " + document['email'].toString() +
                              " to user?"),
                      actions: <Widget>[
                        new FlatButton(
                          child: new Text("Confirm"),
                          onPressed: () {
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
                            Navigator.pop(context);
                          },
                        ),
                        new FlatButton(
                          child: new Text("Cancel"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  }
              );
            }
          } //If user to change is a volunteer, admins may promote to admin, else change to user
          else if(document['role'] == "volunteer"){
            if(currentUserRole != "admin"){
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: new Text("Confirm role change"),
                      content: new Text(
                          "Change " + document['email'].toString() + " to user?"),
                      actions: <Widget>[
                        new FlatButton(
                          child: new Text("Confirm"),
                          onPressed: () {
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
                            Navigator.pop(context);
                          },
                        ),
                        new FlatButton(
                          child: new Text("Cancel"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  }
              );
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: new Text("Confirm role change"),
                      content: new Text(
                          "Change " + document['email'].toString() + " to admin?"),
                      actions: <Widget>[
                        new FlatButton(
                          child: new Text("Confirm"),
                          onPressed: () {
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
                    Navigator.pop(context);
                  },
                ),
                new FlatButton(
                  child: new Text("Cancel"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          }
      );
    }
          } else if(document['role'] == "user"){
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: new Text("Confirm role change"),
                    content: new Text("Change " + document['email'].toString() + " to volunteer?"),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text("Confirm"),
                        onPressed: () {
                          Firestore.instance
                              .runTransaction((transaction) async {
                            await transaction.update(
                                Firestore.instance
                                    .collection("users")
                                    .document(document['uid']),
                                {
                                  'role': "volunteer",
                                });
                          });
                          Navigator.pop(context);
                        },
                      ),
                      new FlatButton(
                        child: new Text("Cancel"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                }
            );
          }
        }),
      subtitle: new Text(
        document['email'],
        style: TextStyle(fontSize: MediaQuery.of(context).size.width / 28),
      ),
    );

  }
}

