import 'dart:convert';

import 'package:app_news/constant/constantFile.dart';
import 'package:app_news/constant/newsModel.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;

class NewsViewModel extends BaseViewModel {
  var _loading = false;
  get loading => _loading;

  final _list = new List<NewsModel>();
  get list => _list;

  Future _lihatData() async {
    _loading = true;
    notifyListeners();
    _list.clear();
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

      _loading = false;
      notifyListeners();
    }
  }

  get lihatData => _lihatData();

  _delete(String id_news) async {
    final response =
        await http.post(BaseUrl().deleteNews, body: {"id_news": id_news});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    if (value == 1) {
      _lihatData();
    } else {
      print(pesan);
    }
  }

  get delete => (id) => _delete(id);
}
