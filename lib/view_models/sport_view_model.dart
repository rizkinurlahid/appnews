import 'package:app_news/constant/constantFile.dart';
import 'package:app_news/constant/respons.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;

class SportViewModel extends BaseViewModel {
  ModelNews _news;
  bool loading = true;

  Future _getNews() async {
    loading = true;
    notifyListeners();

    var res = await http.get(BaseUrl().sportApi);
    if (res.statusCode != 404) if (res.contentLength != 2) {
      _news = modelNewsFromJson(res.body);
    }
    print(_news.status);

    if (_news.status == 'ok') {
      loading = false;

      notifyListeners();
    }
  }

  get getNews => _getNews();
  get articles => _news.articles;
}
