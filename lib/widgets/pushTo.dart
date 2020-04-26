import 'package:flutter/material.dart';

class PushTo extends StatelessWidget {
  const PushTo({
    Key key,
    @required this.text1,
    @required this.text2,
    @required this.to,
  }) : super(key: key);
  final String text1;
  final String text2;
  final Widget to;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          text1,
          style: TextStyle(color: Colors.white),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => to));
          },
          child: Text(
            text2,
            style: TextStyle(color: Colors.lightGreen[600]),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
