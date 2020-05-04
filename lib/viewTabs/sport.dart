import 'package:app_news/constant/respons.dart';
import 'package:app_news/utils/color.dart';
import 'package:app_news/view_models/checkConn.dart';
import 'package:app_news/view_models/sport_view_model.dart';
import 'package:app_news/views/pages/newsDetail.dart';
import 'package:app_news/views/widgets/circularDesign.dart';
import 'package:app_news/views/widgets/noInternet.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stacked/_viewmodel_builder.dart';

class Sport extends StatefulWidget {
  @override
  _SportState createState() => _SportState();
}

class _SportState extends State<Sport> {
  final SportViewModel sportViewModel = SportViewModel();

  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      if (mounted) setState(() => _source = source);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    String string;
    int nilai;
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.none:
        string = "Offline";
        nilai = 0;
        print(string);
        break;
      case ConnectivityResult.mobile:
        string = "Mobile: Online";
        nilai = 1;
        print(string);
        break;
      case ConnectivityResult.wifi:
        string = "WiFi: Online";
        nilai = 2;
        print(string);
    }

    return (nilai == 1 || nilai == 2)
        ? ViewModelBuilder<SportViewModel>.reactive(
            viewModelBuilder: () => sportViewModel,
            onModelReady: (model) => model.getNews,
            disposeViewModel: false,
            builder: (context, model, child) {
              return Scaffold(
                backgroundColor: ColorApp().bgColor,
                body: (model.loading)
                    ? CircularDesign()
                    : buildSport(model, width),
              );
            },
          )
        : NoInternet(
            nilai: nilai,
          );
  }

  ListView buildSport(SportViewModel model, double width) {
    model.articles.sort((list1, list2) {
      return list2.publishedAt
          .toString()
          .compareTo(list1.publishedAt.toString());
    }); //ascending
    return ListView.builder(
      itemCount: model.articles.length,
      itemBuilder: (context, index) {
        Article article = model.articles[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsDetail(
                  article: article,
                  check: 1,
                ),
              ),
            );
          },
          child: Column(
            children: <Widget>[
              ListTile(
                leading: (article.urlToImage != null)
                    ? Image.network(
                        article.urlToImage,
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.fill,
                      )
                    : Container(
                        width: 100.0,
                        height: 100.0,
                        child: Center(
                          child: Text('No Image'),
                        ),
                      ),
                title: Text(
                  (article.title != null) ? article.title : '',
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
                      (article.description != null) ? article.description : '',
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
                      (article.publishedAt != null) ? article.publishedAt : '',
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
        );
      },
    );
  }
}
