import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class feedback_page extends StatefulWidget {
  @override
  _feedback_pageState createState() => _feedback_pageState();
}

class _feedback_pageState extends State<feedback_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      new AppBar(
        title: new Text("Feedback", style: TextStyle(fontSize: MediaQuery.of(context).size.width/20)),
        centerTitle: true,
        elevation: 10.0,
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
      body: Column(
        children: <Widget>[
          Flexible(
            child: StreamBuilder(
                stream: Firestore.instance.collection('CommunityFeedback').snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return new Text('Loading...');
                  return ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.black,
                    ),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) =>
                        _buildListItem(context, snapshot.data.documents[index], snapshot.data.documents[index].documentID),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

Widget _buildListItem(BuildContext context, DocumentSnapshot document, docID) {

  return ListTile(
    title: Row(
      children: [
        Expanded(
          child: Text(
            document['feedback'],
            style: TextStyle(fontSize: MediaQuery.of(context).size.height / 40),
          ),
        ),
      ],
    ),
    leading: new Icon(
      Icons.feedback,
      size: MediaQuery.of(context).size.width / 10,
      color: Colors.blue[700],
    ),
  );
}
