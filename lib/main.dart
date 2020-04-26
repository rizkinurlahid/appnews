import 'package:app_news/mainMenu.dart';
import 'package:app_news/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {

// @override
// void initState() {
//   super.initState();

// }
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "News App",
//       home: (getPref() == 1) ? MainMenu() : Login(),
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         appBarTheme: AppBarTheme(
//           color: Colors.white,
//           iconTheme: IconThemeData(color: Colors.red),
//         ),
//       ),
//     );
//   }
//   var value;
//   getPref() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     value = preferences.getInt("value");
//     return preferences.getInt("value");
//     // _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
//     // notifyListeners();
//   }
// }

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<int> getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt("value");

    // _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    // notifyListeners();
  }

  @override
  void initState() {
    super.initState();
    getPref();

    print(getPref());
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
          color: Colors.white,
          iconTheme: IconThemeData(color: Colors.red),
        ),
      ),
    );
  }
}
