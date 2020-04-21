import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String username = "" , email= "";

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString("username");
      email = preferences.getString("email");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[

        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 32),
                width: 120,
                height: 120,
                child: CircleAvatar(
                  radius: 100,
                  child: Icon(Icons.person),
                  ),
                ),



              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    ListTile(
                        leading: Icon(Icons.person, size: 45,),
                      title : Text("Username : $username"),
                    ),

                    ListTile(
                      leading: Icon(Icons.email,size: 45,),
                      title : Text("Email : $email"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],

    );
  }
}

