import 'package:app_news/utils/color.dart';
import 'package:flutter/material.dart';

class DesignButton extends StatelessWidget {
  const DesignButton({
    Key key,
    @required this.width,
    @required this.press,
    @required this.child,
  }) : super(key: key);

  final double width;
  final Function press;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      child: RaisedButton(
          color: ColorApp().accentColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          onPressed: press,
          child: child),
    );
  }
}
