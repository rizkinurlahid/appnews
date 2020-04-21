import 'dart:convert';

import 'package:app_news/constant/constantFile.dart';
import 'package:app_news/constant/newsModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ItemListHorizontal extends StatefulWidget {
  @override
  _ItemListHorizontalState createState() => _ItemListHorizontalState();
}

class _ItemListHorizontalState extends State<ItemListHorizontal> {
  var loading = false;
  final list = new List<NewsModel>();

  Future _lihatData() async {
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.get(BaseUrl().detailNews);

    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new NewsModel(
          api['id_news'],
          api['image'],
          api['title'],
          api['content'],
          api['description'],
          api['date_news'],
          api['id_users'],
          api['username'],
        );
        list.add(ab);
      });
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lihatData();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
