import 'package:flutter/material.dart';
import 'dart:async';
import 'admin_update_screen.dart';
import 'admin_view_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var itemName = "na";
var fridgeName = "na";
var shopName = "na";
int quantity;
DateTime dateAdded = DateTime.now();

var _ItemsList = [
  "Select item",
];

var _FridgesList = [
  "Select fridge",
];

var _ShopsList = [
  "Select shop",
];

Future getItems() async {
  Firestore.instance.collection('Items').snapshots().listen((data) {
    data.documents.forEach((doc) {
        if(_ItemsList.contains(doc.documentID) == false){
          _ItemsList.add(doc.documentID);
        }
    });
  });
}

Future getFridges() async {
  Firestore.instance.collection('Fridges').snapshots().listen((data) {
    data.documents.forEach((doc) {
      if(_FridgesList.contains(doc.documentID) == false){
        _FridgesList.add(doc.documentID);
      }
    });
  });
}

Future getShops() async {
  Firestore.instance.collection('Shops').snapshots().listen((data) {
    data.documents.forEach((doc) {
      if(_ShopsList.contains(doc.documentID) == false){
        _ShopsList.add(doc.documentID);
      }
    });
  });
}

TextEditingController number_items_controller = TextEditingController();

class add_screen extends StatefulWidget {
  @override
  _add_screenState createState() => _add_screenState();
}

class _add_screenState extends State<add_screen>{
  // Var that will be used in the drop down menu
  var _currentFridgeLocation = _FridgesList[0];
  var _currentShop = _ShopsList[0];
  var _currentItemList = _ItemsList[0];

  var _formKey = GlobalKey<FormState>();

  final TOP_PADDING = 40.0;
  final LEFT_PADDING = 50.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Add Item"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.only(top: TOP_PADDING),
            child: ListView(
              children: <Widget>[
                Center(
                  child: Text(
                    "Add Items",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 50.0,
                    ),
                  ),
                ),

                //Item name
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 35.0,
                          left: 50.0,
                        ),
                        child: Text(
                          "Item Name",
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 40.0,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 35.0, right: 20.0, left: 40.0),
                        child: DropdownButton<String>(
                          items: _ItemsList.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: new Text(dropDownStringItem),
                            );
                          }).toList(),
                          onChanged: (String new_value_selected) {
                            //When an item is selected from the drop down
                            whenItemListDropButton(new_value_selected);
                            itemName = new_value_selected;
                          },
                          value: _currentItemList,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0, top: 40.0),
                      child: IconButton(
                          icon: Icon(Icons.add_circle),
                          onPressed: () {
                            add_alert(context);
                          }),
                    ),
                  ],
                ),

                //Donating shop
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 35.0,
                          left: 50.0,
                        ),
                        child: Text(
                          "Donating Shop",
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 40.0,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 35.0, right: 20.0, left: 40.0),
                        child: DropdownButton<String>(
                          items: _ShopsList.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: new Text(dropDownStringItem),
                            );
                          }).toList(),
                          onChanged: (String new_value_selected) {
                            //When an item is selected from the drop down
                            whenShopDropButton(new_value_selected);
                            shopName = new_value_selected;
                          },
                          value: _currentShop,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0, top: 40.0),
                      child: IconButton(
                          icon: Icon(Icons.add_circle),
                          onPressed: () {
                            addShop_alert(context);
                          }),
                    ),
                  ],
                ),

                //Row for item name text and the text field
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 35.0,
                          left: 50.0,
                        ),
                        child: Text(
                          "Fridge",
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 40.0,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 35.0, right: 20.0, left: 40.0),
                        child: DropdownButton<String>(
                          items: _FridgesList.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: new Text(dropDownStringItem),
                            );
                          }).toList(),
                          onChanged: (String new_value_selected) {
                            //When an item is selected from the drop down
                            whenFridgeDropButton(new_value_selected);
                            fridgeName = new_value_selected;
                          },
                          value: _currentFridgeLocation,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0, top: 40.0),
                      child: IconButton(
                          icon: Icon(Icons.add_circle),
                          onPressed: () {
                            addFridge_alert(context);
                          }),
                    ),
                  ],
                ),

                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 35.0,
                          left: 50.0,
                        ),
                        child: Text(
                          "Quantity",
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 40.0,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 35.0, right: 50.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "Number of items",
                                hintText: "e.g. 9",
                                errorStyle: TextStyle(
                                  color: Colors.yellowAccent,
                                  fontSize: 15,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Please enter a valid number ";
                              }
                            },
                            controller: number_items_controller,
                          ),
                        ))
                  ],
                ),

                //Row for the button confirm button
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Container(
                        width: 300.0,
                        height: 100.0,
                        child: OutlineButton(
                          color: Colors.green,
                          child: Text(
                            "Confirm",
                            textDirection: TextDirection.ltr,
                            style:
                            TextStyle(color: Colors.green, fontSize: 40.0),
                          ),
                          //elevation: 6.0,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              var currentQuantity;
                              Firestore.instance
                                  .collection('Items')
                                  .where("Item name", isEqualTo: itemName)
                                  .snapshots()
                                  .listen((data) =>
                                  data.documents.forEach((doc) => currentQuantity = (doc["Quantity"])));
                              //Add items to database START
                              Firestore.instance
                                  .runTransaction((transaction) async {
                                await transaction.set(
                                    Firestore.instance
                                        .collection("Items")
                                        .document(itemName),
                                    {
                                      'Item name': itemName,
                                      'Date Added': dateAdded,
                                      'Fridge': fridgeName,
                                      'Donator': shopName,
                                      'Quantity': quantity = currentQuantity + int.parse(
                                          number_items_controller.text),
                                    });
                                Navigator.pop(context);
                                addItemNote(context);
                              });
                              //Add items to database END
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          borderSide:
                          BorderSide(color: Colors.green, width: 5.0),
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[Button_Update()],
                )
              ],
            )),
      ),
      bottomNavigationBar: Container(
        height: 70.0,
        child: new BottomAppBar(
          color: Colors.blue,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.view_list, color: Colors.white),
                iconSize: 50.0,
                onPressed: () {
                  // add feedback page/alert - TBD
                  view_list(context);
                },
              ),
              IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                iconSize: 50.0,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              IconButton(
                icon: Icon(Icons.update, color: Colors.white),
                iconSize: 50.0,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => admin_update_screen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void whenItemListDropButton(String new_value_selected) {
    setState(() {
      this._currentItemList = new_value_selected;
    });
  }

  void whenFridgeDropButton(String new_value_selected) {
    setState(() {
      this._currentFridgeLocation = new_value_selected;
    });
  }

  void whenShopDropButton(String new_value_selected) {
    setState(() {
      this._currentShop = new_value_selected;
    });
  }
}

void addItemNote(BuildContext context) {
  var alertDialog = AlertDialog(
    title: Text("Added Item"),
    content: Text("You have added an item"),
  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      });
}

void createFridgeNote(BuildContext context) {
  var alertDialog = AlertDialog(
    title: Text("Created Fridge"),
    content: Text("You have created a new fridge"),
  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      });
}

void createShopNote(BuildContext context) {
  var alertDialog = AlertDialog(
    title: Text("Created Shop"),
    content: Text("You have created a new shop"),
  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      });
}

void createItemNote(BuildContext context) {
  var alertDialog = AlertDialog(
    title: Text("Created Item"),
    content: Text("You have created a new item"),
  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      });
}

//update Button using a staeless widget
class Button_Update extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Container(
        width: 300.0,
        height: 100.0,
        child: OutlineButton(
          color: Colors.orange,
          child: Text(
            "Update",
            textDirection: TextDirection.ltr,
            style: TextStyle(color: Colors.orange, fontSize: 40.0),
          ),
          onPressed: () {
            note_update(context);
          },
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          borderSide: BorderSide(color: Colors.orange, width: 5.0),
        ),
      ),
    );
  }
}

void note_update(BuildContext context) {
  var alertDialog = AlertDialog(
    title: Text("Updating Item"),
    content: Text("You have updated an Item"),
  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      });
}

void add_alert(BuildContext context) {
  var alertDialog = AlertDialog(
    title: Text("Add New Item"),
    content: Row(
      children: <Widget>[
        new Expanded(
          child: new TextField(
            autofocus: true,
            decoration: new InputDecoration(
                labelText: 'Item name', hintText: 'eg. Milk'),
            onChanged: (current) {
              itemName = current;
            }
          ),
        )
  ],
    ),
    actions: <Widget>[
      FlatButton(
        child: Text("Yes"),
        onPressed: () {
          Firestore.instance
              .runTransaction((transaction) async {
            await transaction.set(
                Firestore.instance
                    .collection("Items")
                    .document(itemName),
                {
                  'Item name': itemName,
                  'Date Added': dateAdded,
                  'Fridge': fridgeName,
                  'Donator': shopName,
                  'Quantity': quantity = 0,
                });
          });
          Navigator.pop(context);
          getItems();
          createItemNote(context);
        }),
      FlatButton(
        child: Text("No"),
        onPressed: () {
          //pop the alert from the stack and goes back to the home screen
          Navigator.pop(context);
        },
      )
    ],
  );

  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      });
}

void addFridge_alert(BuildContext context) {
  var alertDialog = AlertDialog(
    title: Text("Add New Fridge"),
    content: Row(
      children: <Widget>[
        new Expanded(
          child: new TextField(
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: 'Fridge Name', hintText: 'eg. Bowland'),
              onChanged: (current) {
                fridgeName = current;
              }
          ),
        )
      ],
    ),
    actions: <Widget>[
      FlatButton(
          child: Text("Yes"),
          onPressed: () {
            Firestore.instance
                .runTransaction((transaction) async {
              await transaction.set(
                  Firestore.instance
                      .collection("Fridges")
                      .document(fridgeName),
                  {
                    'Name': fridgeName,
                  });
            });
            Navigator.pop(context);
            getFridges();
            createFridgeNote(context);
          }),
      FlatButton(
        child: Text("No"),
        onPressed: () {
          //pop the alert from the stack and goes back to the home screen
          Navigator.pop(context);
        },
      )
    ],
  );

  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      });
}

void addShop_alert(BuildContext context) {
  var alertDialog = AlertDialog(
    title: Text("Add New Shop"),
    content: Row(
      children: <Widget>[
        new Expanded(
          child: new TextField(
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: 'Shop Name', hintText: 'eg. Greggs'),
              onChanged: (current) {
                shopName = current;
              }
          ),
        )
      ],
    ),
    actions: <Widget>[
      FlatButton(
          child: Text("Yes"),
          onPressed: () {
            Firestore.instance
                .runTransaction((transaction) async {
              await transaction.set(
                  Firestore.instance
                      .collection("Shops")
                      .document(shopName),
                  {
                    'Name': shopName,
                  });
            });
            Navigator.pop(context);
            getShops();
            createShopNote(context);
          }),
      FlatButton(
        child: Text("No"),
        onPressed: () {
          //pop the alert from the stack and goes back to the home screen
          Navigator.pop(context);
        },
      )
    ],
  );

  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      });
}

void view_list(BuildContext context) {
//action will go to the login screen or user homepage
  Navigator.pop(context);
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => admin_view_screen()));
}

void leave_alert(BuildContext context) {
  //action used to leave the alert
  Navigator.pop(context);
}
