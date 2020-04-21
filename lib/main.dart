import 'dart:convert';
import 'package:app_news/constant/constantFile.dart';
import 'package:app_news/mainMenu.dart';
import 'package:app_news/register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    home: Login(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        appBarTheme: AppBarTheme(
            color: Colors.white, iconTheme: IconThemeData(color: Colors.red))),
  ));
}

enum LoginStatus { notSignIn, signIn }

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;

  String email, password;

  final _key = new GlobalKey<FormState>();

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      login();
    }
  }

  savePref(int value, String username, String email, String id_users) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("username", username);
      preferences.setString("email", email);
      preferences.setString("id_users", id_users);

      preferences.commit();
    });
  }

  login() async {
    final response = await http.post(BaseUrl().login, body: {
      "email": email,
      "password": password,
    });
    final data = jsonDecode(response.body);

    int value = data['value'];
    String pesan = data['message'];
    String usernameAPI = data['username'];
    String emailAPI = data['email'];
    String id_users = data['id_users'];
    if (value == 1) {
      setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(value, usernameAPI, emailAPI, id_users);
      });

      print(pesan);
    } else {
      print(pesan);
    }
  }

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          backgroundColor: Colors.red,
          body: Form(
            key: _key,
            child: Container(
              margin: EdgeInsets.all(32),
              padding:
                  EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Welcome back\nPlease Login to Your Count",
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    validator: (e) {
                      if (e.isEmpty) {
                        return "Please insert email";
                      }
                    },
                    onSaved: (e) => email = e,
                    decoration: InputDecoration(labelText: "Email"),
                  ),
                  TextFormField(
                    obscureText: _secureText,
                    onSaved: (e) => password = e,
                    decoration: InputDecoration(
                        labelText: "Password",
                        suffixIcon: IconButton(
                          onPressed: showHide,
                          icon: Icon(_secureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16, bottom: 16),
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: RaisedButton(
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () {
                        check();
                      },
                      child: Text(
                        "login",
                        style: TextStyle(color: Colors.white, letterSpacing: 3),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Register()));
                      },
                      child: Text(
                        "Create a new account, in Here",
                        style: TextStyle(color: Colors.blue),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
        break;
      case LoginStatus.signIn:
        return MainMenu(signOut);
        break;
    }
  }
}
