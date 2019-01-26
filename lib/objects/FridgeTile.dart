import 'package:flutter/material.dart';

class FridgeTile extends ListTile {

  FridgeTile(
    {
      title: String,
      expiry: String,
      location: String,
    }
  ) : super(
    title: Text(title),
    subtitle: Text(expiry + " (" + location + ")"),
    leading: Icon(
      Icons.face,
      color: Colors.red[500],
    ),
  );

}