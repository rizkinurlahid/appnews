import 'package:app_news/constant/color.dart';
import 'package:app_news/providers/login_view_model.dart';
import 'package:app_news/screens/register.dart';
import 'package:app_news/widgets/bg.dart';
import 'package:app_news/widgets/button.dart';
import 'package:app_news/widgets/logo.dart';
import 'package:app_news/widgets/pushTo.dart';
import 'package:app_news/widgets/textFieldDesign.dart';
import 'package:flutter/material.dart';
import 'package:stacked/_viewmodel_builder.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        onModelReady: (model) => model.getPref(),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
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
                              color: Colors.lightGreen[600],
                            ),
                          ),
                        ),
                        (model.pesanLogin == 0)
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Login Denied",
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: DesignButton(
                          press: () => model.check(context),
                          child: (model.loading == 1)
                              ? Container(
                                  width: 25.0,
                                  height: 25.0,
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Colors.white54),
                                  ),
                                )
                              : Text(
                                  "LOGIN",
                                  style: TextStyle(
                                      color: ColorApp().textOrIcon,
                                      fontSize: 17.0),
                                ),
                          width: width,
                        )),
                    // PushToRegister(),
                    PushTo(
                      text1: "You don't have an account? ",
                      text2: "Register",
                      to: Register(),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
