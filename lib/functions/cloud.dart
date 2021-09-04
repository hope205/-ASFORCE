import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import 'package:asforce/functions/task_data.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:asforce/Screens/control_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../providers/auth_code.dart';

final _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

//this are the keys that that are used to access the realtime database

DatabaseReference ref = FirebaseDatabase.instance.reference().child('Users');

DatabaseReference databaseUid =
    FirebaseDatabase.instance.reference().child('Uid');

DatabaseReference databaseRef =
    FirebaseDatabase.instance.reference().child('Users/$uid/Data/Electricity');

// DatabaseReference databaseHum =
//     FirebaseDatabase.instance.reference().child('Users/$uid/Data/Humidities');

DatabaseReference databaseSecRef =
    FirebaseDatabase.instance.reference().child('Users/$uid/Password');

// DatabaseReference connectedRef = FirebaseDatabase.instance.ref(".info/connected");

String fname;

String Password;

var keys1;
var data1;

int up = 0;

class CloudFunctions {
  //this function fetches the users data that will be need for the running if the app

  Future fetchData({String id, BuildContext context}) async {
    if (up == 0) {
      // Provider.of<Data>(context, listen: false).updateFetch(1);
      //this function starts by fetching the humidities
      // dynamic hum = await fetchHumidities();

      await databaseRef.once().then((DataSnapshot snap) {
        //this list is to stores all the pumps that  it will get from the database

        double volts = snap.value['voltage'];
        double current = snap.value['current'];
        double power = snap.value['power'];

        print(current);

        Provider.of<Data>(context, listen: false)
            .createStartSwitch('Current', current);

        Provider.of<Data>(context, listen: false)
            .createStartSwitch('Voltage', volts);

        Provider.of<Data>(context, listen: false)
            .createStartSwitch('Power', power);
      });
    }

    String ter = "Yes";
    up = 4;
    return ter;
  }

  //this function fetches the users password

  //this fetches the humidity value in the database

  // Future<dynamic> fetchHumid(
  //     {BuildContext context, @required String nam}) async {
  //   dynamic dat;
  //   await databaseHum.once().then((DataSnapshot snap) {
  //     // dat = snap.value[nam]['Humidity'];
  //     dat = snap.value[nam];
  //   });
  //   return dat;
  // }
  //
  // //this is used to fetch all humidity values at the beginning of the application
  // Future<dynamic> fetchHumidities() async {
  //   dynamic dat;
  //   await databaseHum.once().then((DataSnapshot snap) {
  //     dat = snap;
  //   });
  //   return dat;
  // }

  //this is used by the registration screen to create new users in the database
  void createUser({
    @required String user,
    @required String email,
    String password,
    String name,
    String phone,
  }) {
    ref.child(user).set({
      "Name": name,
      "Phone": phone,
      "Email": email,
      "LoggedIn": 0,
      "Password": password
    });
    createData();
  }

  void createData() {
    databaseRef.set({
      "Current": 0.0,
      "Power": 0.0,
      "Voltage": 0.0
      // "Humidity": 0,
    });
  }

  // void createData({
  //   @required String name,
  // }) {
  //   databaseRef.child('$name').set({
  //     "State": "0",
  //     // "Humidity": 0,
  //   });
  // }

  //this function fetches the users loggedin state

  Future<String> fetchLogged({
    @required String uid,
  }) async {
    dynamic log;
    String logged;

    await FirebaseDatabase.instance
        .reference()
        .child('Users/$uid/LoggedIn')
        .once()
        .then((DataSnapshot snap) {
      // dat = snap.value[nam]['Humidity'];
      log = snap.value;
      logged = log.toString();

      // print('this is logged $logged');
    });

    return logged;
  }

  //it is used to update the state of the pumps in the database
  //it is either 1 0r 0

  void updateData({@required int value, @required String name}) {
    databaseRef.child('$name').update({
      "State": value,
    });
    print('sent');
  }

  //this function is used to update the logged in state of the user
  void updateLogged({@required int value, @required String uid}) {
    DatabaseReference databaseLogged =
        FirebaseDatabase.instance.reference().child('Users/$uid');
    databaseLogged.update({"LoggedIn": value});
  }

  Future<String> SignIn({
    @override BuildContext context,
    @override String email,
    @override String password,
  }) async {
    try {
      //it tries to sign in the user to firebase with his email and password
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (user != null) {
        // String v = await fetchLogged(uid: _auth.currentUser.uid);
        String v = "0";
        if (v == "0") {
          // if (v == "1") {

          Provider.of<Data>(context, listen: false).Sign(method: 0);

          return "true";
        } else {
          SignOut(
            context: context,
          );
          return "user is logged in on another device";
        }
      } else {
        return "An Error occurred.";
      }
    } on FirebaseAuthException catch (e) {
      String error = errors(e);

      return error;
    }
  }

  String errors(dynamic error) {
    String errorMessage;
    String d = error.code;
    print("this is error $d");
    switch (d) {
      case "invalid-email":
        errorMessage = "Your email address appears to be malformed.";
        break;
      case "invalid-password":
        errorMessage = "Your password is wrong.";
        break;
      case "user-not-found":
        errorMessage = "This User doesn't exist.";
        break;

      case "too-many-requests":
        errorMessage = "Too many requests. Try again later.";
        break;
      case "email-already-exists":
        errorMessage = "Email is already in use by an existing user";
        break;
      default:
        errorMessage = "An Error occurred.";
    }
    return errorMessage;
  }

  //this enables the user to sign in with his google account
  Future<String> signInWithGoogle({@required BuildContext context}) async {
    // Provider.of<Data>(context, listen: false).updateSpinner(false);
    String check;
    User user;

    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // the users credentials are gotten from his google account
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      user = authResult.user;
    } catch (e) {
      print(e);
    }

    if (user != null) {
      //this line is to check if the user exists
      await FirebaseDatabase.instance
          .reference()
          .child("Users/${user.uid}/Data/Electricity")
          .once()
          .then((DataSnapshot snap) {
        check = snap.value;
      });
      // //this is to get the users token
      // String token = await user.getIdToken();
      //
      // //it takes only ten characters of the users token
      // String Ttoken = token.substring(0, 10);

      String Us = user.email;

      //it gets the loggedIn state of the user that is about to signIn

      if (check == null) {
        createUser(
            user: user.uid,
            email: user.email,
            phone: user.phoneNumber,
            name: user.displayName,
            password: 'none');
        createData();
        if (user.uid != null) {
          //it pushes the user to another screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Check(
                  code: _auth.currentUser.uid,
                );
              },
            ),
          );
        }
        return "An Error occurred.";
      } else {
        //if the user exists,it checks if the user is logged in
        // String v = await fetchLogged(uid: _auth.currentUser.uid);
        String v = "0";
        if (v == "0") {
          //it saves the signIn method of the user
          Provider.of<Data>(context, listen: false).Sign(method: 1);

          print('signInWithGoogle succeeded: $user');

          return 'correct';
        } else {
          SignOut(
            context: context,
          );
          return "User is logged in on another device";
        }
      }
    } else {
      Provider.of<Data>(context, listen: false).updateSpinner(false);
      return "An Error occurred.Try again later";
    }
  }

  Future EmailSignOut() async {
    await _auth.signOut();
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
    await _auth.signOut();

    print("User Signed Out");
  }

  Future SignOut({
    @required context,
  }) async {
    updateLogged(value: 0, uid: _auth.currentUser.uid);
    Provider.of<Data>(context, listen: false).SignInmethod == 0
        ? EmailSignOut()
        : signOutGoogle();
  }

  void showSnackBar({BuildContext context, String message}) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      backgroundColor: Colors.lightBlueAccent,
      behavior: SnackBarBehavior.fixed,
      duration: const Duration(seconds: 5),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }
}
