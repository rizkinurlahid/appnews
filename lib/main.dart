import 'package:app_news/utils/color.dart';
import 'package:app_news/views/pages/login.dart';
import 'package:app_news/views/pages/mainMenu.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((_) {
    runApp(MyApp());
  // });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<int> getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt("value");
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "News App",
      home: FutureBuilder<int>(
        future: getPref(),
        builder: (context, snapshot) {
          if (snapshot.data == 0) {
            return Login();
          } else {
            return MainMenu();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.blueGrey,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        primaryColor: ColorApp().primaryColor,
        accentColor: ColorApp().accentColor,
      ),
    );
  }
}
