import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
