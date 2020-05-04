import 'dart:convert';

import 'package:app_news/constant/constantFile.dart';
import 'package:app_news/constant/newsModel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;

class NewsViewModel extends BaseViewModel {
  var loading = false;

  final _list = new List<NewsModel>();
  get list => _list;

  Future _lihatData() async {
    _list.clear();
    loading = true;
    notifyListeners();

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
        _list.add(ab);
      });

      loading = false;
      notifyListeners();
    }
  }

  get lihatData => _lihatData();

  _delete(String idNews, BuildContext context) async {
    final response =
        await http.post(BaseUrl().deleteNews, body: {"id_news": idNews});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    if (value == 1) {
      _lihatData();
      Navigator.pop(context);
    } else {
      print(pesan);
      Navigator.pop(context);
    }
  }

  get delete => (id, context) => _delete(id, context);
}
