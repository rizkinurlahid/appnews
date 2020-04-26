import 'package:app_news/screens/login.dart';
import 'package:flutter/material.dart';

class PushToLogin extends StatelessWidget {
  const PushToLogin({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "You have an account? ",
          style: TextStyle(color: Colors.white),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Login()));
          },
          child: Text(
            "Login",
            style: TextStyle(color: Colors.lightGreen[600]),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
