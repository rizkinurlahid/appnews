import 'dart:async';

import 'package:app_news/utils/color.dart';
import 'package:app_news/constant/constantFile.dart';
import 'package:app_news/view_models/checkConn.dart';
import 'package:app_news/view_models/home_view_model.dart';
import 'package:app_news/views/pages/newsDetail.dart';
import 'package:app_news/views/widgets/button.dart';
import 'package:app_news/views/widgets/circularDesign.dart';
import 'package:app_news/views/widgets/noInternet.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:stacked/_viewmodel_builder.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeViewModel homeViewModel = HomeViewModel();

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
    final height = MediaQuery.of(context).size.height;
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
        ? ViewModelBuilder<HomeViewModel>.reactive(
            viewModelBuilder: () => homeViewModel,
            onModelReady: (model) => model.lihatData,
            disposeViewModel: false,
            builder: (context, model, child) {
              return Scaffold(
                backgroundColor: ColorApp().bgColor,
                body: RefreshIndicator(
                  onRefresh: () => model.lihatData,
                  child: model.loading
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                ColorApp().accentColor),
                          ),
                        )
                      : buildHome(string, model, height, width),
                ),
              );
            },
          )
        : NoInternet(
            nilai: nilai,
          );
  }

  ListView buildHome(
      String string, HomeViewModel model, double height, double width) {
    model.list.sort((list1, list2) {
      return list2.dateNews.toString().compareTo(list1.dateNews.toString());
    }); //ascending
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Stories",
              style: TextStyle(
                  color: ColorApp().accentColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold)),
        ),
        Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
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
                            )),
                  );
                },
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          BaseUrl().insertNews + x.image,
                          fit: BoxFit.fill,
                          width: 400,
                          height: 300,
                          colorBlendMode: BlendMode.darken,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Container(
                      height: height,
                      width: width,
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 250,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                          title: Text(
                            x.title,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: ColorApp().lightPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Headline",
              style: TextStyle(
                  color: ColorApp().accentColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold)),
        ),
        ListView.builder(
            itemCount: model.list.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              final list = model.list;
              final x = list[i];

              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewsDetail(
                                newsModel: x,
                                check: 0,
                              )));
                },
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Image.network(
                        BaseUrl().insertNews + x.image,
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.fill,
                      ),
                      title: Text(x.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            x.description,
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
                            x.dateNews,
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
            }),
      ],
    );
  }
}
