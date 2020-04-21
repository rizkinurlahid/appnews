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
      print(pesan);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Form(
        key: _key,
        child: Container(
          margin: EdgeInsets.all(32),
          padding: EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Register",
                style: TextStyle(color: Colors.black, fontSize: 24),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "Lets get\nyou on board",
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
              SizedBox(
                height: 24,
              ),
              TextFormField(
                validator: (e) {
                  if (e.isEmpty) {
                    return "Please insert username";
                  }
                },
                onSaved: (e) => username = e,
                decoration: InputDecoration(labelText: "Username"),
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
                    "Register",
                    style: TextStyle(color: Colors.white, letterSpacing: 3),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text(
                    "Already have Acounts? Sing in ",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
