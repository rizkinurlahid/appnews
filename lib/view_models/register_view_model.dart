import 'dart:async';
import 'dart:convert';
import 'package:app_news/constant/constantFile.dart';
import 'package:app_news/views/pages/mainMenu.dart';
import 'package:app_news/views/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/_base_viewmodels.dart';
import 'package:http/http.dart' as http;

class RegisterViewModel extends BaseViewModel {
  // LoginStatus _loginStatus = LoginStatus.notSignIn;
  // get loginStatus => _loginStatus;

  String username, email, password;
  int pesanRegister;

  final _key = new GlobalKey<FormState>();
  get key => _key;

  bool _secureText = true;
  bool get secureText => _secureText;

  int _loading;
  get loading => _loading;

  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  get usernameFocus => _usernameFocus;
  get emailFocus => _emailFocus;
  get passwordFocus => _passwordFocus;
  get usernameFocusDispose => _usernameFocus.dispose();
  get emailFocusDispose => _emailFocus.dispose();
  get passwordFocusDispose => _passwordFocus.dispose();

  showHide() {
    _secureText = !_secureText;
    notifyListeners();
  }

  check(BuildContext context) {
    if (_key.currentState.validate()) {
      _loading = 1;
      _key.currentState.save();
      save(context);
    }
    notifyListeners();
  }

  save(BuildContext context) async {
    final response = await http.post(BaseUrl().register, body: {
      "username": username,
      "email": email,
      "password": password,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    if (value == 1) {
      login(context);
      _loading = 0;
    } else {
      _loading = 0;
      print(value);
      print(pesan);

      pesanRegister = value;
      timer();
    }
    notifyListeners();
  }

  timer() {
    if (pesanRegister == 2) {
      Timer(Duration(seconds: 2), () {
        pesanRegister = 3;
        notifyListeners();
      });
    }
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
      // print(_loginStatus);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainMenu()),
        (Route<dynamic> route) => false,
      );
      notifyListeners();
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

  fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
    notifyListeners();
  }
}
