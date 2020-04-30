import 'package:app_news/constant/constantFile.dart';
import 'package:app_news/constant/newsModel.dart';
import 'package:app_news/constant/respons.dart';
import 'package:app_news/utils/color.dart';
import 'package:flutter/material.dart';

class NewsDetail extends StatefulWidget {
  final NewsModel newsModel;
  final Article article;
  NewsDetail({this.newsModel, this.article});

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    final x = widget.article;
    final y = widget.newsModel;
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
                  (x == null) ? y.title : x.title,
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
                  child: Image.network(
                    (x == null) ? BaseUrl().insertNews + y.image : x.urlToImage,
                    fit: BoxFit.fill,
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
                    (x == null) ? y.dateNews : x.publishedAt,
                    style: TextStyle(
                      color: ColorApp().primaryColor,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    'Author : ${(x == null) ? y.username : x.author}',
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
                (x == null) ? y.content : x.content,
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 7.0,
              ),
              Text(
                (x == null) ? '' : 'For more : ${x.url}',
              ),
            ],
          )),
    );
  }
}
