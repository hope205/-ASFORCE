import 'package:flutter/material.dart';
import '../Screens/login_screen.dart';

import 'package:flutter/services.dart';

class Check extends StatefulWidget {
  static const String id = 'CheckScreen';

  String code;
  Check({this.code});

  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> {
  String value = '';
  int show;

  @override
  void initState() {
    setState(() {
      value = widget.code;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 8.0,
          backgroundColor: Colors.lightBlueAccent,
          leading: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, LoginScreen.id);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: 50,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Authentication Code',
                            style: TextStyle(
                              fontSize: 30.0,
                            ),
                          ),
                          SizedBox(height: 60),
                          Text(
                            // '${Provider.of<Data>(context, listen: true).RegUsers}',
                            '$value',
                            style: TextStyle(
                              fontSize: 35.0,
                              color: Colors.blueAccent,
                            ),
                          ),
                          SizedBox(height: 30),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RaisedButton(
                                  onPressed: () {
                                    Clipboard.setData(
                                        ClipboardData(text: value));
                                    setState(() {
                                      show = 2;
                                    });
                                  },
                                  child: Text('Copy to the clipboard'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 100,
            ),
            Visibility(
              visible: show == 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: RaisedButton(
                      color: Colors.lightBlueAccent,
                      onPressed: () async {
                        Navigator.pushNamed(context, LoginScreen.id);
                        // bool d = await Functions.SaveKey(context);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return BluetoothApp(
                        //         place: 1,
                        //       );
                        //     },
                        //   ),
                        // );
                      },
                      child: Text('Next')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
