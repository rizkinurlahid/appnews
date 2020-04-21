import 'package:app_news/viewTabs/category.dart';
import 'package:app_news/viewTabs/home.dart';
import 'package:app_news/viewTabs/news.dart';
import 'package:app_news/viewTabs/profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainMenu extends StatefulWidget {

  final VoidCallback signOut;
  MainMenu(this.signOut);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

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
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 4, right: 4),
                  alignment: Alignment.center,
                  height: 25,
                  width: 25,
                  color: Colors.red,
                  child: Text("P", style: TextStyle(color: Colors.white),),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4, right: 4),
                  alignment: Alignment.center,
                  height: 25,
                  width: 25,
                  color: Colors.red,
                  child: Text("R", style: TextStyle(color: Colors.white),),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4, right: 4),
                  alignment: Alignment.center,
                  height: 25,
                  width: 25,
                  color: Colors.red,
                  child: Text("O", style: TextStyle(color: Colors.white),),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4, right: 4),
                  alignment: Alignment.center,
                  height: 25,
                  width: 25,
                  color: Colors.red,
                  child: Text("J", style: TextStyle(color: Colors.white),),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4, right: 4),
                  alignment: Alignment.center,
                  height: 25,
                  width: 25,
                  color: Colors.red,
                  child: Text("E", style: TextStyle(color: Colors.white),),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4, right: 4),
                  alignment: Alignment.center,
                  height: 25,
                  width: 25,
                  color: Colors.red,
                  child: Text("C", style: TextStyle(color: Colors.white),),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4, right: 4),
                  alignment: Alignment.center,
                  height: 25,
                  width: 25,
                  color: Colors.red,
                  child: Text("K", style: TextStyle(color: Colors.white),),
                ),
                Text("News", style: TextStyle(color: Colors.red, letterSpacing: 3, fontSize: 25 ),)
              ],
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                signOut();
              },
              icon: Icon(Icons.lock_open, color: Colors.red,),
            )
          ],



        ),
        body: TabBarView(
          children: <Widget>[
            Home(),
            News(),
            Category(),
            Profile(),
          ],
        ),

        bottomNavigationBar: TabBar(
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              style: BorderStyle.none
            )
          ),
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.home),
              text: "Home",
            ),
            Tab(
              icon: Icon(Icons.new_releases),
              text: "News",
            ),
            Tab(
              icon: Icon(Icons.category),
              text: "Category",
            ),

            Tab(
              icon: Icon(Icons.perm_contact_calendar),
              text: "Profile",
            )
          ],
        ),
      ),
    );
  }
}
