import 'package:firebase_auth/firebase_auth.dart';
import '../Utilities/constants.dart';
import 'package:flutter/material.dart';
import '../Utilities/rounded_button.dart';
import 'package:flutter/services.dart';
import 'control_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:asforce/functions/task_data.dart';
import 'registration_screen.dart';
import 'package:form_field_validator/form_field_validator.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:asforce/functions/cloud.dart';

//this is the first screen of the app
//where the user will login into his account

//this imports the cloud based functions needed to send data to the cloud
CloudFunctions cloudBase = CloudFunctions();

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner = false;

  //this is the form key
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //this function is used for checking the validation state of the form
  bool validate() {
    if (formKey.currentState.validate()) {
      print('validated');
      return true;
    } else {
      print('Not Validated');
      return false;
    }
  }

  bool Pressed() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Builder(
        builder: (context) {
          return ModalProgressHUD(
            inAsyncCall: Provider.of<Data>(context, listen: true).showSpinner,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              // this column contains the text fields the user is going to use to enter
              // his email and password
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      height: 150,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.lightBlueAccent,
                                fontSize: 45.0,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 48.0,
                          ),
                          Form(
                            // autovalidate: true,
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: MultiValidator([
                                    RequiredValidator(errorText: "Required *"),
                                    EmailValidator(
                                        errorText: "Not a Valid Email"),
                                  ]),
                                  style: kTextColour,
                                  keyboardType: TextInputType.emailAddress,
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    email = value;
                                  },
                                  decoration: kTextFieldDecoration.copyWith(
                                    hintText: 'Enter your email',
                                  ),
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Required *";
                                    } else {
                                      return null;
                                    }
                                  },
                                  style: kTextColour,
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.center,
                                  obscureText: true,
                                  onChanged: (value) {
                                    password = value;
                                  },
                                  decoration: kTextFieldDecoration.copyWith(
                                    hintText: 'Enter your password.',
                                    prefixIcon: Icon(Icons.lock),
                                  ),
                                ),
                                SizedBox(
                                  height: 35.0,
                                ),
                                RoundedButton(
                                  colour: Colors.lightBlueAccent,
                                  onPressed: () async {
                                    if (validate()) {
                                      Provider.of<Data>(context, listen: false)
                                          .updateSpinner(true);
                                      //this line calls a function that signs in the user
                                      cloudBase.SignIn(
                                        context: context,
                                        email: email,
                                        password: password,
                                      ).then((result) {
                                        if (result != "true") {
                                          cloudBase.showSnackBar(
                                            context: context,
                                            message: result,
                                          );
                                          Provider.of<Data>(context,
                                                  listen: false)
                                              .updateSpinner(false);
                                        } else {
                                          Provider.of<Data>(context,
                                                  listen: false)
                                              .updateSpinner(false);
                                          //this line pushes the user to the control screen
                                          Navigator.pushReplacementNamed(
                                              context, Control.id);
                                        }
                                      });
                                    }
                                  },
                                  title: 'Log In',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                'Forgot password',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.lightBlue,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          )
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   //it measures the size of the screen and divides it to get the value of the
                    //   //space it is going to leave
                    //   height: MediaQuery.of(context).size.height / 4.5,
                    // ),
                    // Row(),
                    // SizedBox(
                    //   height: 20.0,
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 150.0,
                            child: RoundedButton(
                                onPressed: () {},
                                colour: Colors.blueGrey,
                                title: 'Facebook'),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          SizedBox(
                            width: 150.0,
                            child: RoundedButton(
                                onPressed: () {
                                  Provider.of<Data>(context, listen: false)
                                      .updateSpinner(true);
                                  cloudBase
                                      .signInWithGoogle(context: context)
                                      .then((result) {
                                    // Provider.of<Data>(context, listen: false)
                                    //     .updateSpinner(false);
                                    if (result == 'correct') {
                                      Provider.of<Data>(context, listen: false)
                                          .updateSpinner(false);
                                      //this line pushes the user to the control screen
                                      Navigator.pushReplacementNamed(
                                          context, Control.id);
                                    } else if (result == null) {
                                      //it does nothing
                                      Provider.of<Data>(context, listen: false)
                                          .updateSpinner(false);
                                      //do smtin
                                    } else {
                                      //it shows the error in a snackbar
                                      Provider.of<Data>(context, listen: false)
                                          .updateSpinner(false);
                                      cloudBase.showSnackBar(
                                        context: context,
                                        message: result,
                                      );
                                    }
                                  });
                                },
                                colour: Colors.deepOrange,
                                title: 'Google'),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Dont't have an account?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5.0),
                        //it takes the user to the next screen on tap
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, RegistrationScreen.id);
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
