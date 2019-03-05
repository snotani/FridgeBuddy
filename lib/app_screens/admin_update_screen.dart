import 'package:flutter/material.dart';
import 'admin_view_screen.dart';
import 'add_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class admin_update_screen extends StatefulWidget {
  @override
  _admin_update_screenState createState() => new _admin_update_screenState();
}

class _admin_update_screenState extends State<admin_update_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
          new AppBar(
            title: new Text("Update Fridge Items", style: TextStyle(fontSize: MediaQuery.of(context).size.width/20)),
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
                  icon: Icon(Icons.view_list, color: Colors.white),
                  iconSize: MediaQuery.of(context).size.height/23.5,
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => admin_view_screen()));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.home, color: Colors.white),
                  iconSize: MediaQuery.of(context).size.height/23.5,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.white),
                  iconSize: MediaQuery.of(context).size.height/23.5,
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => add_screen()));
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
                  stream: Firestore.instance.collection('Items').snapshots(),
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
            Button_confirm()
          ],
        ),
      );
  }
}

Widget _buildListItem(BuildContext context, DocumentSnapshot document, docID) {

  int quantity_check = 0;

  return ListTile(
    title: Row(
      children: [
        Expanded(
          child: Text(
            document['Item name'],
            style: TextStyle(fontSize: MediaQuery.of(context).size.height / 40),
          ),
        ),
        IconButton(
          icon: Icon(Icons.remove_circle),
          iconSize: MediaQuery.of(context).size.width / 10,
          color: Colors.blue[700],
          onPressed: () {
            // remove one from quantity
            if(document['Quantity'] > 1) {
              quantity_check--;
              print(quantity_check);
              Firestore.instance.runTransaction((transaction) async {
                DocumentSnapshot freshSnap =
                await transaction.get(document.reference);
                await transaction.update(freshSnap.reference, {
                  'Quantity': freshSnap['Quantity'] - 1,
                });
              });
            }
            // Add if statement to check if quantity reaches 0 and then pop up "Are you sure message" to delete the field
            if (document['Quantity'] == 1){
              delete_field_alert(context, docID);
            }
          },
        ),
        Container(
          child: Text(
            document['Quantity'].toString(),
            style: TextStyle(fontSize: MediaQuery.of(context).size.width / 17.5),
          ),
        ),
        IconButton(
          icon: Icon(Icons.add_circle),
          color: Colors.blue[700],
          iconSize: MediaQuery.of(context).size.width / 10,
          onPressed: () {increase_quantity(document, quantity_check); },
        ),
      ],
    ),
    leading: new Icon(
      Icons.fastfood,
      size: MediaQuery.of(context).size.width / 10,
      color: Colors.blue[700],
    ),
    subtitle: new Text(
      document['Donator'],
      style: TextStyle(fontSize: MediaQuery.of(context).size.height / 50),
    ),
  );
}

class Button_confirm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/23.5),
      child: Container(
        width: MediaQuery.of(context).size.width/2.45,
        height: MediaQuery.of(context).size.height/13,
        child: OutlineButton(
          color: Colors.green,
          child: Text(
            "Confirm",
            textDirection: TextDirection.ltr,
            style: TextStyle(color: Colors.green, fontSize: MediaQuery.of(context).size.width / 16.5),
          ),
          onPressed: () {
            confirmDialog(context);
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)),
          borderSide: BorderSide(color: Colors.green,width: 5.0),),
      ),
    );
  }
}

void increase_quantity (DocumentSnapshot document,quantity_check) {
  // add one to quantity
  Firestore.instance.runTransaction((transaction) async {
    DocumentSnapshot freshSnap =
    await transaction.get(document.reference);
    await transaction.update(freshSnap.reference, {
      'Quantity': freshSnap['Quantity'] + 1,
    });
    // Add variable for count and disable add button
    // Initially disabled add button but once the counter is not 0, enable it
  });
}

void confirmDialog(BuildContext context) {
  var alertDialog = AlertDialog(
    title: new Text("Successfull!"),
    content: new Text("You have successfully updated the fridge!"),
  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      });
}

void delete_field_alert (BuildContext context, docID) {
  var alertDialog = AlertDialog(
    title: Text("Delete Item"),
    content: Text("Do you wish to retrieve this last item?"),
    actions: <Widget>[
      FlatButton( child: Text("Yes"),
        onPressed: (){
          delete_field(docID);
          Navigator.pop(context);
        },
      ),
      FlatButton(child: Text("No"),
        onPressed: (){
          stay_on_page(context);
        },
      )
    ],
  );

  showDialog(
      context: context,
      builder: (BuildContext context){
        return alertDialog;

      }
  );
}

//This will delete the item field requested
void delete_field(docID) {
  Firestore.instance
      .collection('Items')
      .document(docID)
      .delete()
      .catchError((error){
    print(error);
  });
}

// This will remain on the page
void stay_on_page(BuildContext context){
  Navigator.pop(context);
}
