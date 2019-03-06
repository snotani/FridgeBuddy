import 'package:flutter/material.dart';
import 'admin_login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class user_update_screen extends StatefulWidget {
  @override
  _user_update_screen createState() => _user_update_screen();
}

class _user_update_screen extends State<user_update_screen> {

  int quantity_count = 0;
  Map<String,int> localCount = new Map();
  Map<String,int> eachItem = new Map();
  Map<String,bool> itemBool = new Map();
  Map<String,Color> buttonColour = new Map();

  @override
  void initState() {
    super.initState();


  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      new AppBar(
        title: new Text(
            "Update Fridge Items", style: TextStyle(fontSize: MediaQuery
            .of(context)
            .size
            .width / 20)),
        centerTitle: true,
        elevation: 10.0,
        leading: logo_image_asset(),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                right: MediaQuery
                    .of(context)
                    .size
                    .width / 60),
            child: IconButton(
              tooltip: 'Admin Login',
              icon: const Icon(Icons.person_add),
              iconSize: MediaQuery
                  .of(context)
                  .size
                  .height / 25,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => login_screen()));
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: MediaQuery
            .of(context)
            .size
            .height / 17.5,
        child: new BottomAppBar(
          color: Colors.blue,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.feedback, color: Colors.white),
                iconSize: MediaQuery
                    .of(context)
                    .size
                    .height / 23.5,
                onPressed: () {
                  feedbackDialog(context);
                },
              ),
              IconButton(
                icon: Icon(Icons.insert_chart, color: Colors.white),
                iconSize: MediaQuery
                    .of(context)
                    .size
                    .height / 23.5,
                onPressed: () {
                  // add analytics- TBD
                  statisticsDialog(context);
                },
              ),
              IconButton(
                icon: Icon(Icons.help, color: Colors.white),
                iconSize: MediaQuery
                    .of(context)
                    .size
                    .height / 23.5,
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
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return new Text('Loading...');
                    if(snapshot.hasError) return new Text(snapshot.error);

                    for(int i=0; i < snapshot.data.documents.length; i++) {
                      localCount.putIfAbsent(snapshot.data.documents[i]['Item name'], () => snapshot.data.documents[i]['Quantity']);
                      eachItem.putIfAbsent(snapshot.data.documents[i]['Item name'], () => 0);
                      itemBool.putIfAbsent(snapshot.data.documents[i]['Item name'], () => true);
                      buttonColour.putIfAbsent(snapshot.data.documents[i]['Item name'], () => Colors.grey[600]);
                    }

                    return ListView.separated(
                      separatorBuilder: (context, index) =>
                          Divider(
                            color: Colors.black,
                          ),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) =>
                          _buildListItem(context, snapshot.data.documents[index],
                              snapshot.data.documents[index].documentID),
                    );
                  }),
          ),
          Flexible(
            child: StreamBuilder(
                stream: Firestore.instance.collection('Items').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return new Text('Loading...');
                  if(snapshot.hasError) return new Text(snapshot.error);

                  for(int i=0; i < snapshot.data.documents.length; i++) {
                    localCount.putIfAbsent(snapshot.data.documents[i]['Item name'], () => snapshot.data.documents[i]['Quantity']);
                    eachItem.putIfAbsent(snapshot.data.documents[i]['Item name'], () => 0);
                    itemBool.putIfAbsent(snapshot.data.documents[i]['Item name'], () => true);
                    buttonColour.putIfAbsent(snapshot.data.documents[i]['Item name'], () => Colors.grey[600]);

                    print(localCount[snapshot.data.documents[i]['Item name']]);
                    print(snapshot.data.documents[i].data['Quantity']);
                    return Button_confirm(snapshot.data.documents[i], snapshot.data.documents[i].data['Quantity'], eachItem[snapshot.data.documents[i]['Item name']]);
                  }
                }
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document, docID) {
    quantity_count = localCount[document['Item name']] - eachItem[document['Item name']];

    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: Text(
              document['Item name'],
              style: TextStyle(fontSize: MediaQuery
                  .of(context)
                  .size
                  .height / 40),
            ),
          ),
          IconButton(
            icon: Icon(Icons.remove_circle),
            iconSize: MediaQuery
                .of(context)
                .size
                .width / 10,
            color: Colors.blue[700],
            onPressed: () {
              // remove one from local quantity
              var maximum = document['Quantity']-1;
              setState(() {
                if(eachItem[document['Item name']] < maximum) {
                  eachItem[document['Item name']]++;
                }
                if (eachItem[document['Item name']] > 0) {
                  itemBool[document['Item name']] = false;
                  buttonColour[document['Item name']] = Colors.blue[700];
                }


              });
            },
          ),
          Container(
            child: Text(
              '$quantity_count',
              style: TextStyle(fontSize: MediaQuery
                  .of(context)
                  .size
                  .width / 17.5),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add_circle),
            color: buttonColour[document['Item name']],
            iconSize: MediaQuery
                .of(context)
                .size
                .width / 10,
            disabledColor: Colors.grey[600],
            onPressed: itemBool[document['Item name']] ? null : () {
              setState(() {
                eachItem[document['Item name']]--;
                if (eachItem[document['Item name']] == 0) {
                  itemBool[document['Item name']] = true;
                  buttonColour[document['Item name']] = Colors.grey[600];
                }
              });
            },
          ),
        ],
      ),
      leading: new Icon(
        Icons.fastfood,
        size: MediaQuery
            .of(context)
            .size
            .width / 10,
        color: Colors.blue[700],
      ),
      subtitle: new Text(
        document['Donator'],
        style: TextStyle(fontSize: MediaQuery
            .of(context)
            .size
            .height / 50),
      ),
    );
  }

  Widget Button_confirm(DocumentSnapshot document, int oldQuantity, int newQuantity) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery
          .of(context)
          .size
          .height / 23.5),
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width / 2.45,
        height: MediaQuery
            .of(context)
            .size
            .height / 13,
        child: OutlineButton(
          color: Colors.green,
          child: Text(
            "Confirm",
            textDirection: TextDirection.ltr,
            style: TextStyle(color: Colors.green, fontSize: MediaQuery
                .of(context)
                .size
                .width / 16.5),
          ),
          onPressed: () {
            confirm_quantity_changes(document, oldQuantity, newQuantity);
            confirmDialog(context);
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)),
          borderSide: BorderSide(color: Colors.green, width: 5.0),),
      ),
    );
  }

  void confirm_quantity_changes(DocumentSnapshot document, int oldQuantity, int newQuantity) {

    /*int quantity_count = 0;
    Map<String,int> localCount = new Map();
    Map<String,int> eachItem = new Map();
    Map<String,bool> itemBool = new Map();
    Map<String,Color> buttonColour = new Map();*/

    setState(() {
      Firestore.instance.runTransaction((transaction) async {
        DocumentSnapshot freshSnap =
        await transaction.get(document.reference);
        await transaction.update(freshSnap.reference, {
          'Quantity': oldQuantity - newQuantity,
        });
        //quantity_count = document['Quantity'];
        //quantity_count = localCount[document['Item name']] - eachItem[document['Item name']];
      });
    });
    
   /* eachItem.forEach((k,v) {
      setState(() {
        eachItem.update(k, (value) => 0);
      });
    });*/

    itemBool.forEach((k,v) {
      setState(() {
        itemBool.update(k, (value) => true);
      });
    });

    buttonColour.forEach((k,v) {
      setState(() {
        buttonColour.update(k, (value) => Colors.grey[600]);
      });
    });


    //initState();
    if (newQuantity == 1) {
      // DELETES THE FIELD INSIDE THIS FUNCTION
      //hide_field_alert(context, docID);
    }
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
            onChanged: (value) {},
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
      content: new Text(
          "Add statistics page here - Pull data of analytics from Firebase"),
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
      content: Text(
          "FridgeBuddy is a project where we aim to reduce food wastage in the university. "
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

  void hide_field_alert(BuildContext context, docID) {
    var alertDialog = AlertDialog(
      title: Text("Delete Item"),
      content: Text("Do you wish to retrieve this last item?"),
      actions: <Widget>[
        FlatButton(child: Text("Yes"),
          onPressed: () {
            //delete_field(docID);
            Navigator.pop(context);
          },
        ),
        FlatButton(child: Text("No"),
          onPressed: () {
            stay_on_page(context);
          },
        )
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
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
        .catchError((error) {
      print(error);
    });
  }

// This will remain on the page
  void stay_on_page(BuildContext context) {
    Navigator.pop(context);
  }
}
