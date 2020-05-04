import 'dart:async';

import 'package:app_news/utils/color.dart';
import 'package:app_news/views/widgets/button.dart';
import 'package:app_news/views/widgets/circularDesign.dart';
import 'package:flutter/material.dart';

class NoInternet extends StatefulWidget {
  final int nilai;
  const NoInternet({Key key, @required this.nilai}) : super(key: key);

  @override
  _NoInternetState createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    if (loading == true) {
      Timer(Duration(seconds: 3), () {
        setState(() => loading = false);
      });
    }
    return Center(
      child: (loading)
          ? CircularDesign()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'No Internet',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: ColorApp().accentColor,
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  child: DesignButton(
                    child: Text(
                      'Retry',
                      style: TextStyle(color: ColorApp().colorText),
                    ),
                    press: () {
                      if (widget.nilai != 1 || widget.nilai != 2) {
                        setState(() => loading = true);
                      }
                    },
                    key: null,
                    width: 100,
                  ),
                ),
              ],
            ),
    );
  }
}
