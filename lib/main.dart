import 'dart:async';
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
        color: Colors.white,
        iconTheme: IconThemeData(color: Colors.red),
      ),
    ),
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
  int pesanLogin;

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

  savePref(int value, String username, String email, String idUsers) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("username", username);
      preferences.setString("email", email);
      preferences.setString("id_users", idUsers);

      // preferences.commit();
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
    String idUsers = data['id_users'];
    if (value == 1) {
      setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(value, usernameAPI, emailAPI, idUsers);
      });

      print(pesan);
    } else {
      print(pesan);
      setState(() {
        pesanLogin = value;
        timer();
      });
    }
  }

  timer() {
    if (pesanLogin == 0) {
      Timer(Duration(seconds: 3), () {
        setState(() {
          pesanLogin = 3;
        });
      });
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
    super.initState();
    getPref();
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      // preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  OutlineInputBorder outlineBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.lightGreen[600],
      ),
      borderRadius: BorderRadius.circular(25.0),
    );
  }

  OutlineInputBorder outlineBorderError() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
      ),
      borderRadius: BorderRadius.circular(25.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          resizeToAvoidBottomPadding: false,
          body: Stack(
            children: <Widget>[
              Container(
                width: width,
                height: height,
                child: Image.asset('images/bg.png',
                    fit: BoxFit.fill,
                    colorBlendMode: BlendMode.darken,
                    color: Colors.black87),
              ),
              Form(
                key: _key,
                child: Container(
                  margin: EdgeInsets.all(width / 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.lightGreen[600],
                          border:
                              Border.all(color: Colors.blueGrey, width: 5.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.pages,
                            size: 60.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: TextFormField(
                              validator: (e) {
                                return (e.isEmpty)
                                    ? "Please Insert Email"
                                    : null;
                              },
                              onSaved: (e) => email = e,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: Colors.lightGreen[600],
                              style: TextStyle(color: Colors.white70),
                              decoration: InputDecoration(
                                labelText: "Email",
                                labelStyle: TextStyle(color: Colors.white54),
                                prefixIcon: Icon(
                                  Icons.alternate_email,
                                  color: Colors.white,
                                ),
                                enabledBorder: outlineBorder(),
                                focusedBorder: outlineBorder(),
                                errorBorder: outlineBorderError(),
                                focusedErrorBorder: outlineBorderError(),
                              ),
                            ),
                          ),
                          TextFormField(
                            validator: (p) {
                              return (p.isEmpty)
                                  ? "Please Insert Password"
                                  : null;
                            },
                            obscureText: _secureText,
                            onSaved: (e) => password = e,
                            cursorColor: Colors.lightGreen[600],
                            style: TextStyle(color: Colors.white70),
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(color: Colors.white54),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                              suffixIcon: IconButton(
                                onPressed: showHide,
                                icon: Icon(
                                  _secureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.lightGreen[600],
                                ),
                              ),
                              enabledBorder: outlineBorder(),
                              focusedBorder: outlineBorder(),
                              errorBorder: outlineBorderError(),
                              focusedErrorBorder: outlineBorderError(),
                            ),
                          ),
                          (pesanLogin == 0)
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Login Denied",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          width: width,
                          height: 50.0,
                          child: RaisedButton(
                            color: Colors.lightGreen[600],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)),
                            onPressed: () {
                              check();
                            },
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 17.0),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "You don't have an account? ",
                            style: TextStyle(color: Colors.white),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Register()));
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(color: Colors.lightGreen[600]),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
        break;
      case LoginStatus.signIn:
        return MainMenu(signOut);
        break;
    }
  }
}
