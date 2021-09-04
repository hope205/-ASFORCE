import 'package:flutter/material.dart';
import 'package:asforce/Screens/control_screen.dart';
import 'package:provider/provider.dart';
import 'package:asforce/functions/task_data.dart';

class Details extends StatelessWidget {
  static const String id = 'Details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        leading: GestureDetector(
          onTap: () {
            Provider.of<Data>(context, listen: false).updateMenu(false);
            Navigator.pushNamed(context, Control.id);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          'About Us',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 30.0,
          ),
        ),
        shadowColor: Colors.blueGrey,
        elevation: 9.0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 70.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    """

                  """,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
