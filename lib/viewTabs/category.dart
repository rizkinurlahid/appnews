import 'package:app_news/viewTabs/sport.dart';
import 'package:app_news/viewTabs/teknologi.dart';
import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: TabBar(
              indicatorColor: Colors.red,
              labelColor: Colors.red,
              unselectedLabelColor: Colors.grey,
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(style: BorderStyle.none)),
              tabs: <Widget>[
                Tab(
                  text: "Teknologi",
                ),
                Tab(
                  text: "Sport",
                ),
//                InkWell(
//                  child: Row(
//                    children: <Widget>[
//                      Icon(Icons.tablet_mac),
//                      Text("Teknologi"),
//
//                    ],
//
//                  ),
//                ),
//              InkWell(
//                child: Row(
//                  children: <Widget>[
//                    Icon(Icons.directions_bike),
//                    Text("Sport"),
//                  ],
//
//                ),
//              ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Teknologi(),
            Sport(),
          ],
        ),
      ),
    );
  }
}
