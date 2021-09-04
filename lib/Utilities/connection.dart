import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:connectivity/connectivity.dart';
import 'package:asforce/Screens/control_screen.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = 'loadingScreen';
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool connect;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.purple,
      body: SafeArea(
        child: StreamBuilder(
          stream: Stream.periodic(Duration(seconds: 2)).asyncMap((i) async {
            connect = await checkStatus();
            // print(length);

            return connect;
          }),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
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
            final bool term = snapshot.data;
            // return Navigate(whether: term);
            return term
                ? Control()
                : Scaffold(
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
          },
        ),
      ),
    );
  }

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
}
