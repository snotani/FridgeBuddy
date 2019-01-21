import 'package:flutter/material.dart';

class add_screen extends StatefulWidget {
  @override
  _add_screenState createState() => _add_screenState();
}

class _add_screenState extends State<add_screen> {
  // Var that will be used in the drop down menu
  var _fridgeLocation = ["Select fridge", "Pendle", "Bowland", "others"];
  var _currentFridgeLocation = ("Select fridge");
  var _Shop = [
    "Select shop",
    "Greggs",
    "Spar",
    "Go Burrito",
    "Sultan",
    "Subway",
    "Wok in",
    "Central"
  ];
  var _currentShop = ("Select shop");
  final TOP_PADDING = 40.0;
  final LEFT_PADDING = 50.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item"),
      ),
      body: Container(
        margin: EdgeInsets.only(top: TOP_PADDING),
        child: Column(
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

            ////Row for item name text and the text field
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
                  padding: const EdgeInsets.only(top: 35.0, right: 50.0),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Item Name",
                        hintText: "e.g. sandwich",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ))
              ],
            ),

            //Row for date added text and the text field
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 35.0,
                      left: 50.0,
                    ),
                    child: Text(
                      "Date Added",
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
                  child: TextField(
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                        labelText: "Date added",
                        hintText: "01/01/2019",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ))
              ],
            ),

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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
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
                      },
                      value: _currentFridgeLocation,
                    ),
                  ),
                )
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
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
                      },
                      value: _currentShop,
                    ),
                  ),
                )
              ],
            ),

            //Row for the button confirm button
            Column(
              children: <Widget>[Button_confirm()],
            ),

            Column(
              children: <Widget>[Button_Update()],
            )
          ],
        ),
      ),
    );
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

// the green confirm button using a stateless widget
class Button_confirm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Container(
        width: 300.0,
        height: 100.0,
        child: RaisedButton(
            color: Colors.green,
            child: Text(
              "Confirm",
              textDirection: TextDirection.ltr,
              style: TextStyle(color: Colors.black, fontSize: 40.0),
            ),
            elevation: 6.0,
            onPressed: () {
              note(context);

              //ADD ITEM TO DATABASE TEST
              //final DocumentReference documentReference =
              //Firestore.instance.document("myData/dummy");

              //Map<String, String> data = <String, String>{
              //  "name": "Pawan Kumar",
              //  "desc": "Flutter Developer"
              //};
              //documentReference.setData(data).whenComplete(() {
              // print("Document Added");
              //}).catchError((e) => print(e));
            }),
      ),
    );
  }
}

void note(BuildContext context) {
  var alertDialog = AlertDialog(
    title: Text("adding Item"),
    content: Text("You have added an Item"),
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
        child: RaisedButton(
            color: Colors.orange,
            child: Text(
              "Update",
              textDirection: TextDirection.ltr,
              style: TextStyle(color: Colors.black, fontSize: 40.0),
            ),
            elevation: 6.0,
            onPressed: () {
              note_update(context);
            }),
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
