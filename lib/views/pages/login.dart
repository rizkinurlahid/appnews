import 'package:app_news/utils/color.dart';
import 'package:app_news/view_models/checkConn.dart';
import 'package:app_news/view_models/login_view_model.dart';
import 'package:app_news/views/pages/register.dart';
import 'package:app_news/views/widgets/bg.dart';
import 'package:app_news/views/widgets/button.dart';
import 'package:app_news/views/widgets/logo.dart';
import 'package:app_news/views/widgets/pushTo.dart';
import 'package:app_news/views/widgets/textFieldDesign.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:stacked/_viewmodel_builder.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LoginViewModel loginViewModel = LoginViewModel();

  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      if (mounted) setState(() => _source = source);
    });
    super.initState();
  }

  @override
  void dispose() {
    loginViewModel.emailFocusDispose;
    loginViewModel.passwordFocusDispose;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    String string;
    int nilai;
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.none:
        string = "Offline";
        nilai = 0;
        print(string);
        break;
      case ConnectivityResult.mobile:
        string = "Mobile: Online";
        nilai = 1;
        print(string);

        break;
      case ConnectivityResult.wifi:
        string = "WiFi: Online";
        nilai = 2;
        print(string);
    }

    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => loginViewModel,
        // onModelReady: (model) => model.getPref(),
        builder: (context, model, child) {
          return Background(
            child: buildLogin(model, width, context, nilai),
          );
        });
  }

  Widget buildLogin(
      LoginViewModel model, double width, BuildContext context, nilai) {
    return Form(
      key: model.key,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(
            30.0,
            MediaQuery.of(context).size.height / 5,
            30,
            MediaQuery.of(context).size.height / 3.5),
        children: <Widget>[
          Logo(),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: TextFieldDesign(
                  colorIcon: ColorApp().textOrIcon,
                  colorLabel: ColorApp().colorLabel,
                  colorText: ColorApp().colorText,
                  maxLines: 1,
                  minLines: 1,
                  radius: 25.0,
                  validator: (e) {
                    return (e.isEmpty) ? "Please Insert Email" : null;
                  },
                  onSaved: (e) => model.email = e,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  focusNode: model.emailFocus,
                  onFieldSubmitted: (term) {
                    model.fieldFocusChange(
                        context, model.emailFocus, model.passwordFocus);
                  },
                  icon: Icons.alternate_email,
                  labelText: 'Email',
                ),
              ),
              TextFieldDesign(
                colorIcon: ColorApp().textOrIcon,
                colorLabel: ColorApp().colorLabel,
                colorText: ColorApp().colorText,
                radius: 25.0,
                validator: (p) {
                  return (p.isEmpty) ? "Please Insert Password" : null;
                },
                obsecureText: model.secureText,
                onSaved: (e) => model.password = e,
                textInputAction: TextInputAction.done,
                focusNode: model.passwordFocus,
                onFieldSubmitted: (value) {
                  model.passwordFocus.unfocus();

                  if (nilai == 1 || nilai == 2) if (model.loading != 1)
                    model.check(context);
                },
                labelText: 'Password',
                icon: Icons.lock,
                suffixIcon: IconButton(
                  onPressed: () => model.showHide(),
                  icon: Icon(
                    model.secureText ? Icons.visibility_off : Icons.visibility,
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
                press: () => (nilai == 1 || nilai == 2)
                    ? (model.loading == 1) ? null : model.check(context)
                    : null,
                child: (nilai == 1 || nilai == 2)
                    ? (model.loading == 1)
                        ? Container(
                            width: 25.0,
                            height: 25.0,
                            child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.white54),
                            ),
                          )
                        : Text(
                            "LOGIN",
                            style: TextStyle(
                                color: ColorApp().textOrIcon, fontSize: 17.0),
                          )
                    : Text(
                        "No Internet",
                        style: TextStyle(
                            color: ColorApp().textOrIcon, fontSize: 17.0),
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
    );
  }
}
