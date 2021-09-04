import 'package:flutter/material.dart';
import 'Secret.dart';
import '../Screens/control_screen.dart';
import 'package:provider/provider.dart';
import '../functions/task_data.dart';

//this is the settings
//it enables the user to connect to the cloud, send authentications codes to the contol
//unit, change wifi names and pass word, and lots more

class Settings extends StatefulWidget {
  static const String id = 'setting_Screen';

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Container(
              child: Text(
                'Primary Settings',
                style: TextStyle(fontSize: 25.0),
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Set_Items(
                  name: 'Authentication Code',
                  route: Secret.id,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Set_Items extends StatelessWidget {
  String name;
  String route;
  Set_Items({@required this.name, @required this.route});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      child: GestureDetector(
        onTap: () async {
          // if (name == 'Cloud Connect') {
          //   bool d = await Functions.SaveKey(context);
          // }

          Navigator.pushNamed(context, route);
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              children: [
                Text(
                  '$name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
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
