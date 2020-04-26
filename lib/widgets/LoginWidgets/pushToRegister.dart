import 'package:app_news/screens/register.dart';
import 'package:flutter/material.dart';

class PushToRegister extends StatelessWidget {
  const PushToRegister({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "You don't have an account? ",
          style: TextStyle(color: Colors.white),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Register()));
          },
          child: Text(
            "Register",
            style: TextStyle(color: Colors.lightGreen[600]),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
