import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  Background({this.child});
  final Widget child;
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
          child
        ],
      ),
    );
  }
}
