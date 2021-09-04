import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  hintStyle: TextStyle(color: Colors.black26),
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  prefixIcon: Icon(Icons.email_sharp),
  hintText: 'Email',
  hintStyle: TextStyle(color: Colors.lightBlueAccent),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    // borderSide: BorderSide(width: 3.0, color: Colors.blue),

    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

// const kTextFieldDecoration = InputDecoration(
//   prefixIcon: Icon(Icons.email_sharp),
//   hintText: 'Email',
//
//   hintStyle: TextStyle(color: Colors.lightBlueAccent),
//   contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//   border: OutlineInputBorder(
//     borderRadius: BorderRadius.all(Radius.circular(32.0)),
//   ),
// //   border: InputBorder.none,
//   // OutlineInputBorder(
//   //   borderRadius: BorderRadius.all(Radius.circular(32.0)),
//   // ),
//   fillColor: Colors.white,
//   filled: true,
//
//   enabledBorder: OutlineInputBorder(
//     borderSide: BorderSide(color: Colors.white, width: 0.0),
//     // borderSide: BorderSide(width: 3.0, color: Colors.blue),
//
//     borderRadius: BorderRadius.all(Radius.circular(32.0)),
//   ),
//   focusedBorder: OutlineInputBorder(
//     borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
//     borderRadius: BorderRadius.all(Radius.circular(32.0)),
//   ),
// );

const kBlueTextFieldDecoration = InputDecoration(
  hintText: 'Enter your Auth Code',
  hintStyle: TextStyle(color: Colors.black26),
  border:
      OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kTextColour = TextStyle(color: Colors.black54);
