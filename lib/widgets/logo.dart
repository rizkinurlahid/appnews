import 'package:app_news/constant/color.dart';
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
        color: ColorApp().accentColor,
        border: Border.all(color: ColorApp().primaryColor, width: 5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.pages,
          size: 60.0,
          color: ColorApp().textOrIcon,
        ),
      ),
    );
  }
}
