import 'package:app_news/utils/color.dart';
import 'package:flutter/material.dart';

class PlaceholderAddNews extends StatelessWidget {
  const PlaceholderAddNews({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        Image.asset(
          'images/placeholder.png',
          fit: BoxFit.fill,
          height: 150.0,
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              "Choose Image",
              style: TextStyle(
                color: ColorApp().lightPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }
}
