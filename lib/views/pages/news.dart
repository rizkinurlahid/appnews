import 'dart:async';

import 'package:app_news/constant/constantFile.dart';
import 'package:app_news/utils/color.dart';
import 'package:app_news/view_models/checkConn.dart';
import 'package:app_news/view_models/news_view_model.dart';
import 'package:app_news/views/pages/addNews.dart';
import 'package:app_news/views/pages/editNews.dart';
import 'package:app_news/views/pages/newsDetail.dart';
import 'package:app_news/views/widgets/button.dart';
import 'package:app_news/views/widgets/circularDesign.dart';
import 'package:app_news/views/widgets/noInternet.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:stacked/_viewmodel_builder.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  final NewsViewModel newsViewModel = NewsViewModel();

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
        ? ViewModelBuilder<NewsViewModel>.reactive(
            viewModelBuilder: () => newsViewModel,
            onModelReady: (model) => model.lihatData,
            disposeViewModel: false,
            builder: (context, model, child) {
              return Scaffold(
                  backgroundColor: ColorApp().bgColor,
                  floatingActionButton: (nilai == 1 || nilai == 2)
                      ? buildFloatingActionButton(context, model)
                      : null,
                  body: RefreshIndicator(
                    onRefresh: () => model.lihatData,
                    child: model.loading
                        ? CircularDesign()
                        : buildNews(model, nilai),
                  ));
            },
          )
        : NoInternet(
            nilai: nilai,
          );
  }

  FloatingActionButton buildFloatingActionButton(
      BuildContext context, NewsViewModel model) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddNews(
                  reload: () => model.lihatData,
                )));
      },
      child: Icon(
        Ionicons.md_add,
        color: ColorApp().lightPrimaryColor,
      ),
      backgroundColor: ColorApp().primaryColor,
    );
  }

  ListView buildNews(NewsViewModel model, nilai) {
    model.list.sort((list1, list2) {
      return list2.dateNews.toString().compareTo(list1.dateNews.toString());
    }); //ascending
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: model.list.length,
        itemBuilder: (context, i) {
          final x = model.list[i];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetail(
                    newsModel: x,
                    check: 0,
                  ),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(1.5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: ColorApp().accentColor,
                                width: 1.0,
                              ),
                            ),
                            child: Image.network(
                              BaseUrl().insertNews + x.image,
                              width: 100.0,
                              height: 100.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                x.title,
                                softWrap: true,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                x.description,
                                softWrap: true,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13.0,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                x.dateNews,
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              InkWell(
                                child: Icon(
                                  FontAwesome5.edit,
                                  color: Colors.lightBlue[300],
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => EditNews(
                                        model: x,
                                        reload: () => model.lihatData,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              (nilai == 1 || nilai == 2)
                                  ? InkWell(
                                      child: Icon(
                                        FontAwesome5.trash_alt,
                                        color: Colors.red[300],
                                      ),
                                      onTap: () {
                                        _onAlertButtonPressed(
                                            context,
                                            () => model.delete(
                                                x.id_news, context));
                                      },
                                    )
                                  : null,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Divider(
                      color: ColorApp().accentColor,
                      height: 0.5,
                      thickness: 0.75,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _onAlertButtonPressed(context, VoidCallback delete) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Action",
      desc: "Are you sure you want to delete this News?",
      buttons: [
        DialogButton(
          child: Text(
            "CANCEL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        ),
        DialogButton(
          color: Colors.red[400],
          child: Text(
            "DELETE",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: delete,
          width: 120,
        )
      ],
    ).show();
  }
}
