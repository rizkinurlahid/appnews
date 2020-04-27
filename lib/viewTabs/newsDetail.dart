import 'package:app_news/constant/constantFile.dart';
import 'package:app_news/constant/newsModel.dart';
import 'package:flutter/material.dart';

class NewsDetail extends StatefulWidget {
  final NewsModel newsModel;
  NewsDetail(this.newsModel);

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    BaseUrl().insertNews + widget.newsModel.image,
                    width: 150.0,
                    height: 120.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                widget.newsModel.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(widget.newsModel.date_news),
              SizedBox(
                height: 5,
              ),
              Text(widget.newsModel.description),
            ],
          )),
    );
  }
}
