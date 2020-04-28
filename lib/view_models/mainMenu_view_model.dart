import 'package:app_news/viewTabs/category.dart';
import 'package:app_news/views/pages/news.dart';
import 'package:app_news/viewTabs/profile.dart';
import 'package:app_news/views/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class MainMenuViewModel extends BaseViewModel {
  String _username = "", _email = "";
  get username => _username;
  get email => _email;

  int selectedIndex = 0;
  PageController _pageController = PageController();

  get pageController => _pageController;
  get disposePage => _pageController.dispose();

  final _tabItems = [
    Home(),
    News(),
    Category(),
    Profile(),
  ];
  get tabItems => _tabItems;

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("value", 0);
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    _username = preferences.getString("username");
    _email = preferences.getString("email");
    notifyListeners();
  }

  jumpTo(int index) {
    _pageController.jumpToPage(index);
  }
}
