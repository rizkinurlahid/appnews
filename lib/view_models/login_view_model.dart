import 'dart:async';
import 'dart:convert';
import 'package:app_news/constant/constantFile.dart';
import 'package:app_news/views/pages/mainMenu.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;

class LoginViewModel extends BaseViewModel {
  // LoginStatus _loginStatus = LoginStatus.notSignIn;
  // get loginStatus => _loginStatus;

  String email, password;
  int pesanLogin;

  final _key = new GlobalKey<FormState>();
  get key => _key;

  bool _secureText = true;
  bool get secureText => _secureText;

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  get emailFocus => _emailFocus;
  get passwordFocus => _passwordFocus;

  int _loading;
  get loading => _loading;

  showHide() {
    _secureText = !_secureText;
    notifyListeners();
  }

  check(BuildContext context) {
    if (_key.currentState.validate()) {
      _loading = 1;
      _key.currentState.save();
      login(context);
    }

    notifyListeners();
  }

  savePref(int value, String username, String email, String idUsers) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("value", value);
    preferences.setString("username", username);
    preferences.setString("email", email);
    preferences.setString("id_users", idUsers);
    notifyListeners();
  }

  login(BuildContext context) async {
    final response = await http.post(BaseUrl().login, body: {
      "email": email,
      "password": password,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    String usernameAPI = data['username'];
    String emailAPI = data['email'];
    String idUsers = data['id_users'];
    if (value == 1) {
      // _loginStatus = LoginStatus.signIn;
      savePref(value, usernameAPI, emailAPI, idUsers);
      print(pesan);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainMenu()),
        (Route<dynamic> route) => false,
      );
      _loading = 0;
    } else {
      print(pesan);
      pesanLogin = value;
      timer();
      _loading = 0;
    }
    notifyListeners();
  }

  timer() {
    if (pesanLogin == 0) {
      Timer(Duration(seconds: 2), () {
        pesanLogin = 3;
        notifyListeners();
      });
      notifyListeners();
    }
  }

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    value = preferences.getInt("value");
    // _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    notifyListeners();
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("value", 0);
    // preferences.commit();
    // _loginStatus = LoginStatus.notSignIn;
    notifyListeners();
  }

  fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
    notifyListeners();
  }
}
