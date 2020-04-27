import 'package:app_news/constant/color.dart';
import 'package:app_news/providers/register_view_model.dart';
import 'package:app_news/screens/login.dart';
import 'package:app_news/widgets/bg.dart';
import 'package:app_news/widgets/button.dart';
import 'package:app_news/widgets/logo.dart';
import 'package:app_news/widgets/pushTo.dart';
import 'package:app_news/widgets/textFieldDesign.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

enum LoginStatus { notSignIn, signIn }

class _RegisterState extends State<Register> {
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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return ViewModelBuilder<RegisterViewModel>.reactive(
        viewModelBuilder: () => RegisterViewModel(),
        onModelReady: (model) => null,
        builder: (context, model, child) {
          return Background(
            child: Form(
              key: model.key,
              child: Container(
                margin: EdgeInsets.all(width / 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Logo(),
                    Column(
                      children: <Widget>[
                        TextFieldDesign(
                          validator: (e) {
                            return (e.isEmpty)
                                ? "Please Insert Username"
                                : null;
                          },
                          onSaved: (e) => model.username = e,
                          textInputAction: TextInputAction.next,
                          focusNode: model.usernameFocus,
                          onFieldSubmitted: (term) {
                            model.fieldFocusChange(
                                context, model.usernameFocus, model.emailFocus);
                          },
                          icon: Icons.person,
                          labelText: 'Username',
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFieldDesign(
                            validator: (e) {
                              return (e.isEmpty) ? "Please Insert Email" : null;
                            },
                            onSaved: (e) => model.email = e,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            focusNode: model.emailFocus,
                            onFieldSubmitted: (term) {
                              model.fieldFocusChange(context, model.emailFocus,
                                  model.passwordFocus);
                            },
                            icon: Icons.alternate_email,
                            labelText: 'Email',
                          ),
                        ),
                        TextFieldDesign(
                          validator: (p) {
                            return (p.isEmpty)
                                ? "Please Insert Password"
                                : null;
                          },
                          obsecureText: model.secureText,
                          onSaved: (e) => model.password = e,
                          textInputAction: TextInputAction.done,
                          focusNode: model.passwordFocus,
                          onFieldSubmitted: (value) {
                            model.passwordFocus.unfocus();
                            model.check(context);
                          },
                          labelText: 'Password',
                          icon: Icons.lock,
                          suffixIcon: IconButton(
                            onPressed: () => model.showHide(),
                            icon: Icon(
                              model.secureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: ColorApp().accentColor,
                            ),
                          ),
                        ),
                        (model.pesanRegister == 2)
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Email already in use",
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            : Container()
                      ],
                    ),
                    DesignButton(
                      press: () => model.check(context),
                      child: (model.loading == 1)
                          ? Container(
                              width: 25.0,
                              height: 25.0,
                              child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.white54),
                              ),
                            )
                          : Text(
                              "REGISTER",
                              style: TextStyle(
                                  color: ColorApp().textOrIcon, fontSize: 17.0),
                            ),
                      width: width,
                    ),
                    // PushToLogin(),
                    PushTo(
                      text1: "You have an account? ",
                      text2: "Login",
                      to: Login(),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
