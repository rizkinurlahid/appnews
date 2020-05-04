import 'package:app_news/utils/color.dart';
import 'package:flutter/material.dart';

class CircularDesign extends StatelessWidget {
  const CircularDesign({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(ColorApp().accentColor),
      ),
    );
  }
}
