import 'package:flutter/material.dart';
import 'Screen_Widgets.dart';
import 'package:asforce/functions/cloud.dart';

// this class contains the functions needed to manage the state of your app

CloudFunctions cloud = CloudFunctions();

class Data extends ChangeNotifier {
  //declarations

  // registered users details
  String name = '';
  String value = '';
  String key = '';

  String Send;
  String RegUsers = '';

  int SignInmethod;
  int fetch;
  int Permit;
  int enter;
  int LoggedState;

  bool isMenuOpen = false;
// controls state of spinner
  bool showSpinner = false;

  double height = 0.0;

  // switch functions

  List<Map> result;

  Map<String, bool> status = {
    'status1': false,
  };

  Map<String, double> HumidVals = {
    'Hum': 1.0,
  };

  Map<String, double> height_1 = {
    'status1': 0.5,
  };

  //this contains the list of switched that show up on the users screen
  List<Content> Switches = [];

  int DropDownValue = 0;

  //functions

  //this method keeps track of the sign in method of the logged in user
  int Sign({@required int method}) {
    SignInmethod = method;
    notifyListeners();
  }

  int Enter({@required int rep}) {
    enter = rep;
    notifyListeners();
  }

  int updateLogState(@required int rep) {
    LoggedState = rep;
    notifyListeners();
  }

  // builds the UI of the screen at start up
  void createStartSwitch(String itemName, double humid) {
    //
    // createStatus(itemName, state);

    //this lines add each switch button to the list of switches
    //each of the switch buttons are contained in the content class
    Switches.add(Content(
      item: itemName,
    ));

    SaveHumid(itemName, humid);

    Save_height_1(name: itemName, height: humid);

    notifyListeners();
  }

  //saves the incoming moisture content values
  void SaveHumid(String name, double humid) {
    double ret = humid;
    HumidVals[name] = ret;

    notifyListeners();
  }

  //this functions saves the previous values of the flutter guage
  void Save_height_1({String name, height}) {
    double ret = height;
    height_1[name] = height;

    notifyListeners();
  }

  //it creates the  status of the switch widgets
  void createStatus(String name, int state) {
    if (state == 1) {
      status[name] = true;
    } else {
      status[name] = false;
    }

    notifyListeners();
  }

  bool SwitchState(String identity) {
    return status[identity];
  }

  //it toggles the switch state
  bool ChangeSwitchState(String identity) {
    return status[identity] = !status[identity];
  }

  //changes the switch status

  void changStatus({bool value, String identity}) {
    int state;
    status[identity] = value;

    if (value == true) {
      cloud.updateData(name: identity, value: 1);
    } else {
      cloud.updateData(name: identity, value: 0);
    }

    notifyListeners();
  }

  // Database functions

  void updateName(String mane1) {
    name = mane1;

    notifyListeners();
  }

  void updateVlaue(String val) {
    value = val;
    notifyListeners();
  }

  int updatePermit(int perm) {
    Permit = perm;

    notifyListeners();
  }

  void updateFetch(int per) {
    fetch = per;

    notifyListeners();
  }

  void updateReg(String reg) {
    RegUsers = reg;

    notifyListeners();
  }

  void updateHumidity(String name, double reg) {
    double ret = reg;
    HumidVals[name] = ret;

    notifyListeners();
  }

  bool updateMenu(bool reg) {
    isMenuOpen = reg;

    notifyListeners();
  }

  bool updateSpinner(bool reg) {
    showSpinner = reg;

    notifyListeners();
  }

  void updatekey(String name) {
    key = name;
    notifyListeners();
  }

  int updateDropValue(int reg) {
    DropDownValue = reg;

    notifyListeners();
  }

  String updateSend(String reg) {
    Send = reg;

    notifyListeners();
  }
}
