import 'package:app_news/constant/constantFile.dart';
import 'package:app_news/constant/newsModel.dart';
import 'package:app_news/constant/respons.dart';
import 'package:app_news/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetail extends StatefulWidget {
  final NewsModel newsModel;
  final Article article;
  final int check;
  NewsDetail({this.newsModel, this.article, @required this.check});

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    final check = widget.check;
    final y = widget.newsModel;
    final x = widget.article;

    return Scaffold(
      backgroundColor: ColorApp().bgColor,
      appBar: AppBar(
        title: Text("News"),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  (check == 0) ? y.title : (check == 1) ? x.title : 'No Title',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(3.0),
                  child: (check == 0)
                      ? Image.network(
                          BaseUrl().insertNews + y.image,
                          fit: BoxFit.fill,
                        )
                      : (check == 1)
                          ? Image.network(
                              x.urlToImage,
                              fit: BoxFit.fill,
                            )
                          : Container(
                              child: Center(
                                child: Text('data'),
                              ),
                            ),
                ),
              ),
              SizedBox(
                height: 1.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    (check == 0)
                        ? y.dateNews
                        : (check == 1) ? x.publishedAt : 'No Date',
                    // _ifElse(x, y, x.publishedAt, y.dateNews, 'No Date'),
                    style: TextStyle(
                      color: ColorApp().primaryColor,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    // 'Author : ${_ifElse(x, y, x.author, y.username, 'No Author')}',
                    'Author : ${(check == 0) ? y.username : (check == 1) ? x.author : 'No Author'}',

                    style: TextStyle(
                      color: ColorApp().primaryColor,
                      fontSize: 12.0,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 7.0,
              ),
              Text(
                (check == 0)
                    ? y.content
                    : (check == 1) ? x.content : 'No Content',
                // _ifElse(x, y, x.content, y.content, 'No Content'),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 7.0,
              ),
              (check == 1)
                  ? Text(
                      'For more :',
                    )
                  : Container(),
              (check == 1)
                  ? GestureDetector(
                      child: Text(
                        (x.url != null) ? x.url : 'No Url',
                        // _ifElse(x, y, x.url, '', 'No Url'),
                        style: TextStyle(color: Colors.cyan),
                      ),
                      onTap: () => _launchURL(x.url),
                    )
                  : Container(),
            ],
          )),
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
