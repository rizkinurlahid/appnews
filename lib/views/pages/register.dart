import 'package:app_news/utils/color.dart';
import 'package:app_news/view_models/checkConn.dart';
import 'package:app_news/view_models/register_view_model.dart';
import 'package:app_news/views/pages/login.dart';
import 'package:app_news/views/widgets/bg.dart';
import 'package:app_news/views/widgets/button.dart';
import 'package:app_news/views/widgets/logo.dart';
import 'package:app_news/views/widgets/pushTo.dart';
import 'package:app_news/views/widgets/textFieldDesign.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final RegisterViewModel registerViewModel = RegisterViewModel();

  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      if (mounted) setState(() => _source = source);
    });
  }

  @override
  void dispose() {
    registerViewModel.usernameFocusDispose;
    registerViewModel.emailFocusDispose;
    registerViewModel.passwordFocusDispose;
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

    return ViewModelBuilder<RegisterViewModel>.reactive(
        viewModelBuilder: () => registerViewModel,
        builder: (context, model, child) {
          return Background(
            child: buildRegister(model, width, context, nilai),
          );
        });
  }

  Form buildRegister(
      RegisterViewModel model, double width, BuildContext context, nilai) {
    return Form(
      key: model.key,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(
            30.0,
            MediaQuery.of(context).size.height / 5,
            30,
            MediaQuery.of(context).size.height / 6),
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
                    return (e.isEmpty) ? "Please Insert Username" : null;
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
              ),
              TextFieldDesign(
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: TextFieldDesign(
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
                      model.secureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: ColorApp().accentColor,
                    ),
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
            press: () => (nilai == 1 || nilai == 2)
                ? (model.loading == 1) ? null : model.check(context)
                : null,
            child: (nilai == 1 || nilai == 2)
                ? (model.loading == 1)
                    ? Container(
                        width: 25.0,
                        height: 25.0,
                        child: CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.white54),
                        ),
                      )
                    : Text(
                        "REGISTER",
                        style: TextStyle(
                            color: ColorApp().textOrIcon, fontSize: 17.0),
                      )
                : Text(
                    "No Internet",
                    style:
                        TextStyle(color: ColorApp().textOrIcon, fontSize: 17.0),
                  ),
            width: width,
          ),
          // PushToLogin(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: PushTo(
              text1: "You have an account? ",
              text2: "Login",
              to: Login(),
            ),
          ),
        ],
      ),
    );
  }
}
