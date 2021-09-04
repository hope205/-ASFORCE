import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String location;

class Helper {
  String input;
  bool isConnect;
  String message;
  // ilara akure
  String url;

  // String path =
  //     "https://api.openweathermap.org/data/2.5/weather?q=London&appid=262049dc5a078512a95ee95dc083b8cc#";

  String path =
      "https://api.openweathermap.org/data/2.5/forecast?q=akure&appid=262049dc5a078512a95ee95dc083b8cc#";

  final messageTextController = TextEditingController();

  Future<String> getNoValue(url) async {
    http.Response response = await http.get(url);
  }

  // Future<String> getValue(url, location) async {
  //   http.Response response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     String data = response.body;
  //     //String decodedData = await jsonDecode(data);
  //
  //     // var decodedData = await jsonDecode(data);
  //     //
  //     //return decodedData;
  //     return data;
  //   } else {
  //     print(response.statusCode);
  //   }
  // }

  Future<dynamic> getJsonValue(location) async {
    try {
      //await
      http.Response response = await http.get(Uri.parse(path));
      print(response.statusCode);
      // if (response.statusCode == 200) {
      String data = response.body;
      // print(data);

      var decodedData = await jsonDecode(data);
      // print(decodedData);

      return decodedData;
      // } else {
      //   print(response.statusCode);
      // }
    } catch (e) {
      print('this is except $e');
    }
  }

  Future PromptUser({@required context, String message}) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            height: 250,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 120,
                    ),
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        color: Colors.blueAccent,
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 20,
                      child: Text(
                        message,
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: TextField(
                    controller: messageTextController,
                    onChanged: (value) {
                      input = value;
                    },
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueAccent.shade200,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                    onPressed: () {
                      messageTextController.clear();

                      Navigator.pop(context, input);
                    },
                    child: Text(
                      'Send',
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
