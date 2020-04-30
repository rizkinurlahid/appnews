import 'package:app_news/utils/color.dart';
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
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: ColorApp().lightPrimaryColor),
              ),
              tabs: <Widget>[
                Tab(
                  text: "Teknologi",
                ),
                Tab(
                  text: "Sport",
                ),
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
