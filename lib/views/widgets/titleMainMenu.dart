import 'package:app_news/utils/color.dart';
import 'package:flutter/material.dart';

class TitleMainMenu extends StatelessWidget {
  const TitleMainMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(3.0),
          alignment: Alignment.center,
          color: ColorApp().accentColor,
          child: Text(
            "PROJECT",
            style: TextStyle(
              color: ColorApp().textOrIcon,
              letterSpacing: 5.0,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(3.0),
          alignment: Alignment.center,
          child: Text(
            "News",
            style: TextStyle(
              color: ColorApp().textOrIcon,
              letterSpacing: 2.0,
              fontSize: 25,
            ),
          ),
        )
      ],
    );
  }
}
