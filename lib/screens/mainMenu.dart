import 'package:app_news/constant/color.dart';
import 'package:app_news/providers/mainMenu_view_model.dart';
import 'package:app_news/screens/login.dart';
import 'package:app_news/widgets/titleMainMenu.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:stacked/_viewmodel_builder.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  void initState() {
    super.initState();
    MainMenuViewModel().getPref();
    MainMenuViewModel().pageController;
  }

  @override
  void dispose() {
    MainMenuViewModel().disposePage;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainMenuViewModel>.reactive(
        viewModelBuilder: () => MainMenuViewModel(),
        onModelReady: (model) => model.getPref(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: TitleMainMenu(),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    model.signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  icon: Icon(
                    FontAwesome.sign_out,
                  ),
                  tooltip: 'Sign Out',
                )
              ],
            ),
            body: Center(
              child: PageView(
                controller: model.pageController,
                onPageChanged: (index) {
                  setState(() {
                    model.selectedIndex = index;
                  });
                },
                children: model.tabItems,
              ),
            ),
            bottomNavigationBar: FFNavigationBar(
              theme: FFNavigationBarTheme(
                barBackgroundColor: Colors.blueGrey,
                selectedItemBorderColor: Colors.blueGrey,
                selectedItemIconColor: Colors.white,
                selectedItemBackgroundColor: ColorApp().accentColor,
                selectedItemLabelColor: Colors.white,
                unselectedItemIconColor: ColorApp().lightPrimaryColor,
                unselectedItemLabelColor: ColorApp().lightPrimaryColor,
              ),
              selectedIndex: model.selectedIndex,
              onSelectTab: (index) {
                setState(() {
                  model.selectedIndex = index;
                });
                model.pageController.jumpToPage(index);
              },
              items: [
                FFNavigationBarItem(
                  iconData: Icons.home,
                  label: 'Home',
                ),
                FFNavigationBarItem(
                  iconData: Icons.new_releases,
                  label: 'News',
                ),
                FFNavigationBarItem(
                  iconData: Icons.category,
                  label: 'Category',
                ),
                FFNavigationBarItem(
                  iconData: Icons.person,
                  label: 'Profile',
                ),
              ],
            ),
          );
        });
  }
}
