import 'dart:async';
import 'dart:convert';
import 'package:app_news/constant/constantFile.dart';
import 'package:app_news/main.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String username, email, password;
  int pesanRegister;

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
      save();
    }
  }

  save() async {
    final response = await http.post(BaseUrl().register, body: {
      "username": username,
      "email": email,
      "password": password,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    if (value == 1) {
      setState(() {
        Navigator.pop(context);
      });
    } else {
      print(value);
      print(pesan);
      setState(() {
        pesanRegister = value;
        timer();
      });
    }
  }

  timer() {
    if (pesanRegister == 2) {
      Timer(Duration(seconds: 3), () {
        setState(() {
          pesanRegister = 3;
        });
      });
    }
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
                      border: Border.all(color: Colors.blueGrey, width: 5.0),
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
                      TextFormField(
                        validator: (u) {
                          return (u.isEmpty) ? "Please Insert Username" : null;
                        },
                        onSaved: (u) => username = u,
                        cursorColor: Colors.lightGreen[600],
                        style: TextStyle(color: Colors.white70),
                        decoration: InputDecoration(
                          labelText: "Username",
                          labelStyle: TextStyle(color: Colors.white54),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          enabledBorder: outlineBorder(),
                          focusedBorder: outlineBorder(),
                          errorBorder: outlineBorderError(),
                          focusedErrorBorder: outlineBorderError(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          validator: (e) {
                            return (e.isEmpty) ? "Please Insert Email" : null;
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
                        validator: (e) {
                          return (e.isEmpty) ? "Please Insert Email" : null;
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
                      (pesanRegister == 2)
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Email already in use",
                                style: TextStyle(color: Colors.red),
                              ),
                            )
                          : Container()
                    ],
                  ),
                  Container(
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
                        "REGISTER",
                        style: TextStyle(color: Colors.white, fontSize: 17.0),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "You have an account? ",
                        style: TextStyle(color: Colors.white),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.lightGreen[600]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
