import 'package:app_news/utils/color.dart';
import 'package:flutter/material.dart';

OutlineInputBorder outlineBorder(radius) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.lightGreen[600],
    ),
    borderRadius: BorderRadius.circular(radius),
  );
}

OutlineInputBorder outlineBorderError(radius) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
    ),
    borderRadius: BorderRadius.circular(radius),
  );
}

class TextFieldDesign extends StatelessWidget {
  const TextFieldDesign({
    Key key,
    @required this.validator,
    @required this.onSaved,
    this.keyboardType,
    @required this.textInputAction,
    @required this.focusNode,
    this.onFieldSubmitted,
    @required this.labelText,
    this.icon,
    this.obsecureText,
    this.suffixIcon,
    @required this.radius,
    @required this.colorText,
    @required this.colorLabel,
    @required this.colorIcon,
    this.maxLines,
    this.minLines,
    this.controller,
  }) : super(key: key);

  final Function validator;
  final Function onSaved;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final Function onFieldSubmitted;
  final String labelText;
  final IconData icon;
  final bool obsecureText;
  final IconButton suffixIcon;
  final double radius;
  final Color colorText;
  final Color colorLabel;
  final Color colorIcon;
  final int maxLines;
  final int minLines;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      toolbarOptions: ToolbarOptions(
        selectAll: true,
        copy: true,
        paste: true,
      ),
      controller: controller,
      validator: validator,
      onSaved: onSaved,
      maxLines: (obsecureText == null) ? maxLines : 1,
      minLines: (obsecureText == null) ? minLines : 1,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: (obsecureText == null) ? false : obsecureText,
      cursorColor: ColorApp().accentColor,
      style: TextStyle(color: colorText),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: colorLabel),
        prefixIcon: Icon(
          icon,
          color: colorIcon,
        ),
        suffixIcon: suffixIcon,
        enabledBorder: outlineBorder(radius),
        focusedBorder: outlineBorder(radius),
        errorBorder: outlineBorderError(radius),
        focusedErrorBorder: outlineBorderError(radius),
      ),
    );
  }
}
