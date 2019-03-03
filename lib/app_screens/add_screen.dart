import 'package:flutter/material.dart';
import 'dart:async';
import 'admin_update_screen.dart';
import 'admin_view_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


var name = "na";
DateTime dateAdded = DateTime.now();
var fridgeLocation = "na";
var donator = "na";
int quantity;
bool lock = false;

var _ItemsList = [
  "Select item",
];

//void getItems(){
//    Firestore.instance.collection('Items').snapshots().listen((data) {
//      data.documents.forEach((doc) {
//        _ItemsList.add(doc.documentID);
//      });
//      print(_ItemsList);
//    });
//}

Future getItems() async {
  _ItemsList = [
    "Select item",
  ];
  print("Before getItems = " + _ItemsList.toString());
  await Firestore.instance.collection('Items').snapshots().listen((data) {
    data.documents.forEach((doc) {
        if(_ItemsList.contains(doc) == false){
          _ItemsList.add(doc.documentID);
        }
    });
  });
  print("After getItems = " + _ItemsList.toString());
}

TextEditingController number_items_controller = TextEditingController();

class add_screen extends StatefulWidget {
  @override
  _add_screenState createState() => _add_screenState();
}

class _add_screenState extends State<add_screen>{

  // Var that will be used in the drop down menu
  var _fridgeLocation = ["Select fridge", "Pendle", "Bowland", "Others"];
  var _currentFridgeLocation = ("Select fridge");
  var _Shop = [
    "Select shop",
    "Greggs",
    "Cafe21",
    "Go Burrito",
    "Bowland Bar",
    "LUSU Central",
    "Juicafe"
  ];

  var _currentShop = ("Select shop");

  var _currentItemList = "Select item";

  var _formKey = GlobalKey<FormState>();

  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2018),
        lastDate: DateTime(2050));

    if (picked != null && picked != _date) {
      print(_date.toString());
      setState(() {
        _date = picked;
        dateAdded = _date;
      });
    }
  }

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
                            print("ItemList = " + _ItemsList.toString());
                            whenItemListDropButton(new_value_selected);
                            name = new_value_selected;
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
                //Row for date added text and the text field

                //Row for the fridge text and the drop down menu
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
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, right: 247.0),
                      child: DropdownButton<String>(
                        items: _fridgeLocation.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                        onChanged: (String new_value_selected) {
                          //when u selected an item from the list
                          whenFridgeDropButton(new_value_selected);
                          fridgeLocation = new_value_selected;
                        },
                        value: _currentFridgeLocation,
                      ),
                    ),
                  ],
                ),

                //Row for the donating shop also drop down menu for the shops
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
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, right: 252.0),
                      child: DropdownButton<String>(
                        items: _Shop.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                        onChanged: (String new_value_selected) {
                          //when u selected an item from the list
                          whenShopDropButton(new_value_selected);
                          donator = new_value_selected;
                        },
                        value: _currentShop,
                      ),
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
                                  .where("Item name", isEqualTo: name)
                                  .snapshots()
                                  .listen((data) =>
                                  data.documents.forEach((doc) => currentQuantity = (doc["Quantity"])));
                              //Add items to database START
                              Firestore.instance
                                  .runTransaction((transaction) async {
                                await transaction.set(
                                    Firestore.instance
                                        .collection("Items")
                                        .document(name),
                                    {
                                      'Item name': name,
                                      'Date Added': dateAdded,
                                      'Fridge': fridgeLocation,
                                      'Donator': donator,
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

  //made a method so it can be modified easier and
  void whenShopDropButton(String new_value_selected) {
    setState(() {
      this._currentShop = new_value_selected;
    });
  }
}

void addItemNote(BuildContext context) {
  var alertDialog = AlertDialog(
    title: Text("Adding Item"),
    content: Text("You have added an Item"),
  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      });
}

void createItemNote(BuildContext context) {
  var alertDialog = AlertDialog(
    title: Text("Creating Item"),
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
              name = current;
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
                    .document(name),
                {
                  'Item name': name,
                  'Date Added': dateAdded,
                  'Fridge': fridgeLocation,
                  'Donator': donator,
                  'Quantity': quantity = 0,
                });
          });
          Navigator.pop(context);
          Navigator.pop(context);
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

/*
void log_out(BuildContext context) {
  var alertDialog = AlertDialog(
    title: Text("LogOut"),
    content: Text("Do you wish to log out?"),
    actions: <Widget>[
      FlatButton(child: Text("Yes"),
        onPressed: () {
          logging_out(context);
        },
      ),
      FlatButton(child: Text("No"),
        onPressed: () {
          leave_alert(context);
        },
      )
    ],
  );*/

 /* showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      }
  );
}*/
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
