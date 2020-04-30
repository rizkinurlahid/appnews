import 'package:app_news/constant/respons.dart';
import 'package:app_news/utils/color.dart';
import 'package:app_news/views/pages/newsDetail.dart';
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
    print(news.status);
    if (news.status == 'ok') setState(() => loading = false);
    return news;
  }

  @override
  void initState() {
    getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: news.articles.length,
              itemBuilder: (context, index) {
                Article article = news.articles[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetail(
                          article: article,
                        ),
                      ),
                    );
                  },

                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Image.network(
                          article.urlToImage,
                          width: 100.0,
                          height: 100.0,
                          fit: BoxFit.fill,
                        ),
                        title: Text(
                          article.title,
                          softWrap: true,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              article.description,
                              maxLines: 1,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: ColorApp().secondaryText,
                                fontWeight: FontWeight.w500,
                                fontSize: 13.0,
                              ),
                            ),
                            Text(
                              article.publishedAt,
                              style: TextStyle(fontSize: 11.0),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        indent: width / 10,
                        endIndent: width / 10,
                      )
                    ],
                  ),

                  // return Card(
                  //   margin: EdgeInsets.all(8),
                  //   child: ListTile(
                  //     contentPadding: EdgeInsets.all(8),
                  //     leading: Image.network(
                  //       "${article.urlToImage}",
                  //       width: 100,
                  //     ),
                  //     title: Text(article.title),
                  //     subtitle: Text(article.author ?? "-"),
                  //   ),
                  // );
                );
              },
            ),
    );
  }
}
