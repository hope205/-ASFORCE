import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../functions/cloud.dart';
import 'Settings.dart';
import 'package:firebase_auth/firebase_auth.dart';

CloudFunctions database = CloudFunctions();

class Secret extends StatefulWidget {
  static const String id = 'secret';

  @override
  _SecretState createState() => _SecretState();
}

class _SecretState extends State<Secret> {
  String code = '';

  int res = 0;

  @override
  Widget build(BuildContext context) {
    // Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        leading: GestureDetector(
          onTap: () {
            setState(() {
              res = 0;
            });
            Navigator.pushNamed(context, Settings.id);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 30.0,
          ),
        ),
        shadowColor: Colors.blueGrey,
        elevation: 9.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 30),
              Container(height: 40),
              Text(
                '${FirebaseAuth.instance.currentUser.uid}',
                style: TextStyle(
                  fontSize: 35.0,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RaisedButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(
                        text: FirebaseAuth.instance.currentUser.uid,
                      ));
                    },
                    child: Text('Copy to the clipboard'),
                    color: Colors.cyan,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
