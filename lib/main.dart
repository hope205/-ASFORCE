import 'package:flutter/material.dart';
import 'Screens/control_screen.dart';
import 'Screens/login_screen.dart';
import 'Screens/registration_screen.dart';
import 'package:provider/provider.dart';
import 'package:asforce/functions/task_data.dart';
import 'providers/auth_code.dart';
import 'providers/Settings.dart';
import 'providers/Secret.dart';
import 'package:firebase_core/firebase_core.dart';
import 'functions/network.dart';
import 'Utilities/connection.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:asforce/Screens/welcome.dart';

// final auth = FirebaseAuth.instance;
bool direction;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  direction = localLogged();

  print('this direct $direction');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Data(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: direction ? Welcome.id : LoginScreen.id,
        routes: {
          Welcome.id: (context) => Welcome(),
          Control.id: (context) => Control(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          Check.id: (context) => Check(),
          Settings.id: (context) => Settings(),
          Secret.id: (context) => Secret(),
          // Details.id: (context) => Details(),
          LoadingScreen.id: (context) => LoadingScreen()
        },
      ),
    );
  }
}

bool localLogged() {
  //
  // // it gets the currentUser;
  // auth.authStateChanges().listen((User user) {
  //   if (user == null) {
  //     print("this user: $user");
  //     location = false;
  //   } else {
  //     print("this user: $user");
  //     location = true;
  //   }
  // });

  // bool logged;

  String d = FirebaseAuth.instance.currentUser.toString();

  print("this is beg $d");

  // //this line pushes the user to the control screen
  if (d == "null") {
    return false;
  } else {
    return true;
  }

  // print("this user $currentUser2"); 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
}
