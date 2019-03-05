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
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0), // here the desired height
          child: new AppBar(
            title: new Text("Update Fridge Items", style: TextStyle(fontSize: 40.0)),
            centerTitle: true,
            elevation: 10.0,
            actions:  <Widget> [
              IconButton(
                tooltip: 'Admin Login',
                icon: const Icon(Icons.person_add),
                iconSize: 50.0,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> login_screen()));
                },
              ),
            ],
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
                    feedbackDialog(context);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.insert_chart, color: Colors.white),
                  iconSize: 50.0,
                  onPressed: () {
                    // add analytics- TBD
                    statisticsDialog(context);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.help, color: Colors.white),
                  iconSize: 50.0,
                  onPressed: () {
                    helpDialog(context);
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
            style: Theme.of(context).textTheme.headline,
          ),
        ),
        IconButton(
          icon: Icon(Icons.remove_circle),
          iconSize: 50.0,
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
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.only(top: 15.0),
          child: Text(
            document['Quantity'].toString(),
            style: Theme.of(context).textTheme.display1,
          ),

        ),
        IconButton(
          icon: Icon(Icons.add_circle),
          color: Colors.blue[700],
          iconSize: 50.0,
          //onPressed: (quantity_check == 0) ? () => increase_quantity(document, quantity_check) : null,
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

class Button_confirm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Container(
        width: 450.0,
        height: 80.0,
        child: OutlineButton(
          color: Colors.green,
          child: Text(
            "Confirm",
            textDirection: TextDirection.ltr,
            style: TextStyle(color: Colors.green, fontSize: 40.0),
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

void feedbackDialog(BuildContext context) {
  var alertDialog = AlertDialog(
    title: new Text("Feedback"),
    content: new Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(hintText: 'Enter feedback here...'),
          onChanged: (value) {

          },
        ),
        SizedBox(height: 10.0,)
      ],
    ),

  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      });
}

void statisticsDialog(BuildContext context) {
  var alertDialog = AlertDialog(
    title: new Text("Statistics"),
    content: new Text("Add statistics page here - Pull data of analytics from Firebase"),
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
    content: Text("FridgeBuddy is a project where we aim to reduce food wastage in the university. "
        "The project would do this by helping both staff and students monitor the contents of the Community Fridge. "
        "This will also include statistics about the Community Fridge usage to reduce even more food waste within the University.",
        style: TextStyle(height: 2.0)),
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
