import 'dart:convert';

import 'package:app_news/constant/constantFile.dart';
import 'package:app_news/constant/newsModel.dart';
import 'package:http/http.dart' as http;
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final _list = new List<NewsModel>();
  get list => _list;

  var loading = false;

  Future _lihatData() async {
    _list.clear();
    loading = true;
    notifyListeners();

    final response = await http.get(BaseUrl().detailNews);
    if (response.statusCode != 404) if (response.contentLength == 2) {
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
}
