import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_portal/flutter_portal.dart';
import '../functions/cloud.dart';
import 'package:provider/provider.dart';
import '../functions/task_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../providers/Settings.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:connectivity/connectivity.dart';
import 'package:asforce/Notifications/LocalNotifyManager.dart';
import 'login_screen.dart';
import 'package:asforce/Utilities/aboutUs.dart';
import 'package:asforce/Utilities/connection.dart';
import 'package:asforce/functions/network.dart';

// it imports the cloud based functions class
CloudFunctions database = CloudFunctions();
Helper Network_help = Helper();

final _auth = FirebaseAuth.instance;

String uid = _auth.currentUser.uid;

enum Confirmation { Logout, Stay }

class Control extends StatefulWidget {
  static const String id = 'Control_screen';

  @override
  _ControlState createState() => _ControlState();
}

class _ControlState extends State<Control> {
  String value;
  Future tem;
  int get;
  bool isConnect = true;

  Future getName() async {
    value = await database.fetchData(context: context);

    return value;
  }

  @override
  void initState() {
    super.initState();

    // checkStatus();

    //it initializes the notification plug in
    // notificationPlugin.setOnNotificationRecieve(onNotificationReceived);
    // notificationPlugin.setOnNotificationClick(onNotificationClick);

    tem = getName();

    //it updates the logged in state of the user in the database
    database.updateLogged(
      value: 1,
      uid: _auth.currentUser.uid,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: tem,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Wait();
          case ConnectionState.done:
            return ModalProgressHUD(
              inAsyncCall: Provider.of<Data>(context, listen: true).showSpinner,
              child: MainScreen(),
            );
          default:
            return Container();
        }
      },
    );
  }

  onNotificationReceived(Function onNotificationReceived) {
    //
  }

  onNotificationClick(String payload) {
    //now
  }
}

class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  bool connect;

  Future<bool> checkStatus() async {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        return true;
      } else {
        return false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.purple,
      body: SafeArea(
        child: StreamBuilder(
          stream: Stream.periodic(Duration(seconds: 9)).asyncMap((i) async {
            connect = await checkStatus();
            // print(length);

            return connect;
          }),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Wait();
            }
            final bool term = snapshot.data;
            // return Navigate(whether: term);
            return term ? MainScreen() : LoadingScreen();
          },
        ),
      ),
    );
  }
}

//this is the page that shows up while the app is trying to fetch the users data
class Wait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            //Navigator.pushNamed(context, LoginScreen.id);
          },
        ),
        title: Text(
          'Irrigation Control',
          style: TextStyle(
            fontSize: 25,
            // fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 7.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Center(
        child: SpinKitChasingDots(
          color: Colors.lightBlueAccent,
          size: 100.0,
        ),
      ),
    );
  }
}

//this is the page that shows up when the app has gotten all the users data
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // the poratal enables you to be able to use overlays in the app
    //it has to be included at the top of the widget tree
    return Portal(
      //cliprect helps to curve the container that covers the screen so that it
      //can fit in with the shape of the screen
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: GestureDetector(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.grey,
                ),
                onTap: () {
                  //Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
              elevation: 0.0,
              title: Text(
                'Pumps',
                style: TextStyle(
                  fontSize: 25,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Center(
                    child: PortalEntry(
                      // visible: isMenuOpen,
                      visible:
                          Provider.of<Data>(context, listen: true).isMenuOpen,
                      portalAnchor: Alignment.topRight,
                      childAnchor: Alignment.topRight,
                      // the portal contains the widgets that are going to be contained
                      // in the overlay
                      portal: Material(
                        elevation: 8.0,
                        child: IntrinsicWidth(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, Settings.id);
                                  },
                                  child: SizedBox(
                                    height: 20.0,
                                    child: Text(
                                      'Settings',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                ),
                              ),
                              ListTile(
                                title: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, Details.id);
                                  },
                                  child: SizedBox(
                                    height: 30.0,
                                    child: Text(
                                      'About Us',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                ),
                              ),
                              ListTile(
                                title: InkWell(
                                  onTap: () async {
                                    Confirmation report = await LogOutDialog(
                                        context: context,
                                        text: 'Do you really want to logout?',
                                        title: 'Logout',
                                        option1: 'LOGOUT');
                                    if (report == Confirmation.Logout) {
                                      Provider.of<Data>(context, listen: false)
                                          .updateSpinner(true);
                                      try {
                                        await database.SignOut(
                                          context: context,
                                        );
                                      } catch (e) {
                                        print("exception: $e");
                                      }
                                      Provider.of<Data>(context, listen: false)
                                          .updateMenu(false);
                                      Provider.of<Data>(context, listen: false)
                                          .updateSpinner(false);
                                      // Navigator.pop(context);
                                      // Navigator.pushNamed(
                                      //     context, LoginScreen.id);
                                      Navigator.pushReplacementNamed(
                                          context, LoginScreen.id);
                                      // SystemNavigator.pop(animated: true);
                                    } else {
                                      Provider.of<Data>(context, listen: false)
                                          .updateMenu(false);
                                      // Navigator.pushNamed(context, LoginScreen.id);
                                    }
                                  },
                                  child: SizedBox(
                                    height: 30.0,
                                    width: 20.0,
                                    child: Text(
                                      'LogOut',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      child: GestureDetector(
                        child: Icon(
                          Icons.more_vert,
                          color: Colors.grey,
                        ),
                        onTap: () {
                          Provider.of<Data>(context, listen: false)
                              .updateMenu(true);
                          // setState(() {
                          //   isMenuOpen = true;
                          // });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: Center(
              //this second portal entry enables the overlay to disappear when you
              //touch any other part of the screen.
              child: PortalEntry(
                //the visibility property makes the portal visible when it is true
                //and vise versa.it makes use of the provider package to check the
                //value of the isMenuOpen
                visible: Provider.of<Data>(context, listen: false).isMenuOpen,
                portal: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    //it updates the value of isMenuOpen ontap
                    Provider.of<Data>(context, listen: false).updateMenu(false);
                    // setState(() {
                    //   isMenuOpen = false;
                    // });
                  },
                ),
                child: Container(
                  child: Column(
                    children: [
                      // Container(
                      //   height: 30,
                      // ),
                      Container(
                        height: MediaQuery.of(context).size.height / 2 + 95,
                        child: ListView(
                          children: Provider.of<Data>(context, listen: false)
                              .Switches,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          print('press');
                          dynamic loc =
                              await Network_help.getJsonValue('akure');
                          print(loc);
                        },
                        child: Text('Get prediction'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future LogOutDialog(
    {@required BuildContext context,
    @required String text,
    String title,
    @required String option1}) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: title != null ? Text(title) : null,
          content: Text(text),
          actions: [
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop(Confirmation.Stay);
              },
            ),
            TextButton(
              child: Text(option1),
              onPressed: () {
                Navigator.of(context).pop(Confirmation.Logout);
              },
            ),
          ],
        );
      });
}
