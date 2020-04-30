import 'package:app_news/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String username = "", email = "";

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString("username");
      email = preferences.getString("email");
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorApp().bgColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 33.0),
        child: Center(
          child: Column(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: ColorApp().primaryColor,
                radius: 50,
                child: Icon(
                  Ionicons.md_person,
                  size: 50.0,
                  color: ColorApp().lightPrimaryColor,
                ),
              ),
              Container(
                width: width / 1.5,
                child: ListTile(
                  leading: Icon(
                    Ionicons.md_person,
                    size: 30,
                    color: ColorApp().primaryColor,
                  ),
                  title: Text("Username : "),
                  subtitle: Text(username),
                ),
              ),
              Container(
                width: width / 1.5,
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    size: 30,
                    color: ColorApp().primaryColor,
                  ),
                  title: Text("Email : "),
                  subtitle: Text(email),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
