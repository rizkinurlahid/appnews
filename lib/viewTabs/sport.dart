import 'package:app_news/constant/responsTechnology.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Sport extends StatefulWidget {
  @override
  _SportState createState() => _SportState();
}

class _SportState extends State<Sport> {
  ModelNews news;
  bool loading = true;

  Future<ModelNews> getNews() async {
    var res = await http.get(
        'http://newsapi.org/v2/top-headlines?country=id&category=sport&apiKey=36fe26ba67d64765b26ca5e8eaf017b0');
    news = modelNewsFromJson(res.body);
    print(news);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: news.articles.length,
              itemBuilder: (context, index) {
                Article article = news.articles[index];

                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(8),
                    leading: Image.network(
                      "${article.urlToImage}",
                      width: 100,
                    ),
                    title: Text(article.title),
                    subtitle: Text(article.author ?? "-"),
                  ),
                );
              }),
    );
  }
}
