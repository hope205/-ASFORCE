import '../providers/auth_code.dart';
import 'package:asforce/functions/cloud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:asforce/Utilities/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:asforce/Utilities/constants.dart';
import 'login_screen.dart';
import 'package:form_field_validator/form_field_validator.dart';

//this imports the cloud based functions needed to send data to the cloud
CloudFunctions cloudBase = CloudFunctions();

class RegistrationScreen extends StatefulWidget {
  static const String id = 'Registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  //this lines initializes the variables that will be needed
  String email;
  String trialPassword;
  String password;
  String number;
  String name;
  bool showSpinner = false;

  //this initialises the firebase authentication class
  final _auth = FirebaseAuth.instance;

  String Newuid = '';

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool validate() {
    if (formKey.currentState.validate()) {
      print('validated');
      return true;
    } else {
      print('Not Validated');
      return false;
    }
  }

  String validatePass(value) {
    if (value.isEmpty) {
      return "Required";
    } else if (value.length < 9) {
      return "Should be at least 9 Characters";
    } else if (value.length > 15) {
      return "Should Not Be More Than 15 Characters";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, LoginScreen.id);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        // title: Text(
        //   'Settings',
        //   style: TextStyle(
        //     color: Colors.black,
        //     fontWeight: FontWeight.w700,
        //     fontSize: 30.0,
        //   ),
        // ),
        shadowColor: Colors.blueGrey,
        // elevation: 9.0,
      ),
      // the ModalProgressHUD shows the spinner when it is true
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  // this column contains the text fields needed for registration
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: Text(
                          'Registration',
                          style: TextStyle(
                              color: Colors.lightBlueAccent,
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Form(
                        autovalidate: true,
                        key: formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 48.0,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Required *";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.left,
                              style: kTextColour,
                              onChanged: (value) {
                                name = value;
                              },
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Company Name',
                                prefixIcon: Icon(Icons.person),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Required *";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.left,
                              style: kTextColour,
                              onChanged: (value) {
                                number = value;
                              },
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Phone',
                                prefixIcon: Icon(Icons.phone),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Required *"),
                                EmailValidator(errorText: "Not a Valid Email"),
                              ]),
                              keyboardType: TextInputType.emailAddress,
                              textAlign: TextAlign.left,
                              style: kTextColour,
                              onChanged: (value) {
                                email = value;
                              },
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Email',
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              validator: validatePass,
                              style: kTextColour,
                              textAlign: TextAlign.left,
                              obscureText: true,
                              onChanged: (value) {
                                trialPassword = value;
                              },
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Password',
                                  prefixIcon: Icon(Icons.lock_open)),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Required *";
                                } else if (password != trialPassword) {
                                  return "Incorrect Password";
                                } else {
                                  return null;
                                }
                              },
                              style: kTextColour,
                              textAlign: TextAlign.left,
                              obscureText: true,
                              onChanged: (value) {
                                password = value;
                              },
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Confirm Password',
                                prefixIcon: Icon(Icons.lock),
                              ),
                            ),
                            SizedBox(
                              height: 24.0,
                            ),
                            RoundedButton(
                              colour: Colors.lightBlueAccent,
                              onPressed: () async {
                                // validate();
                                if (validate()) {
                                  setState(() {
                                    showSpinner = true;
                                  });
                                  try {
                                    //this lines tries to register the user in firebase
                                    // authentication usiing his email and password
                                    var newUser = await _auth
                                        .createUserWithEmailAndPassword(
                                            email: email, password: password);
                                    //this lines uses the authentication code of the newly
                                    //created user and other informations from the textfield
                                    //to create an account for the user in the firebase realtime database
                                    cloudBase.createUser(
                                      user: _auth.currentUser.uid,
                                      email: email,
                                      password: password,
                                      name: name,
                                      phone: number,
                                    );
                                    //if the user has been created successfully, it takes the user to
                                    //the next page
                                    if (newUser != null) {
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
                                    setState(() {
                                      showSpinner = false;
                                    });
                                  } catch (e) {
                                    String error = cloudBase.errors(e);

                                    cloudBase.showSnackBar(
                                      context: context,
                                      message: error,
                                    );
                                  }
                                } else {
                                  print("cannot go");
                                }
                              },
                              title: 'Register',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                    ],
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
