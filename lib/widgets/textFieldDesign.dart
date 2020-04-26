import 'package:flutter/material.dart';

OutlineInputBorder outlineBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.lightGreen[600],
    ),
    borderRadius: BorderRadius.circular(25.0),
  );
}

OutlineInputBorder outlineBorderError() {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
    ),
    borderRadius: BorderRadius.circular(25.0),
  );
}

class TextFieldDesign extends StatelessWidget {
  const TextFieldDesign({
    Key key,
    @required this.validator,
    @required this.onSaved,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.onFieldSubmitted,
    @required this.labelText,
    @required this.icon,
    this.obsecureText,
    this.suffixIcon,
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

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onSaved: onSaved,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: (obsecureText == null) ? false : obsecureText,
      cursorColor: Colors.lightGreen[600],
      style: TextStyle(color: Colors.white70),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white54),
        prefixIcon: Icon(
          icon,
          color: Colors.white,
        ),
        suffixIcon: suffixIcon,
        enabledBorder: outlineBorder(),
        focusedBorder: outlineBorder(),
        errorBorder: outlineBorderError(),
        focusedErrorBorder: outlineBorderError(),
      ),
    );
  }
}
