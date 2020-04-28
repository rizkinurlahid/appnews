import 'dart:convert';

import 'package:app_news/constant/constantFile.dart';
import 'package:app_news/constant/newsModel.dart';
import 'package:http/http.dart' as http;
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final _list = new List<NewsModel>();
  get list => _list;

  var _loading = false;
  get loading => _loading;

  Future _lihatData() async {
    list.clear();
    _loading = true;
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
        list.add(ab);
      });

      _loading = false;
      notifyListeners();
    }
  }

  get lihatData => _lihatData();
}
