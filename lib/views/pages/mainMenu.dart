import 'package:app_news/utils/color.dart';
import 'package:app_news/view_models/mainMenu_view_model.dart';
import 'package:app_news/views/pages/login.dart';
import 'package:app_news/views/widgets/titleMainMenu.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:stacked/_viewmodel_builder.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final MainMenuViewModel menuViewModel = MainMenuViewModel();
  @override
  void initState() {
    super.initState();
    menuViewModel.pageController;
  }

  @override
  void dispose() {
    menuViewModel.disposePage;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainMenuViewModel>.reactive(
        viewModelBuilder: () => menuViewModel,
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
                  icon: Icon(FontAwesome.sign_out),
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
                  iconData: FontAwesome.home,
                  label: 'Home',
                ),
                FFNavigationBarItem(
                  iconData: AntDesign.edit,
                  label: 'Control',
                ),
                FFNavigationBarItem(
                  iconData: Icons.category,
                  label: 'Category',
                ),
                FFNavigationBarItem(
                  iconData: Ionicons.md_person,
                  label: 'Profile',
                ),
              ],
            ),
          );
        });
  }
}
