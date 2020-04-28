import 'package:app_news/constant/constantFile.dart';
import 'package:app_news/constant/newsModel.dart';
import 'package:app_news/utils/color.dart';
import 'package:app_news/viewTabs/addNews.dart';
import 'package:app_news/viewTabs/editNews.dart';
import 'package:app_news/viewTabs/newsDetail.dart';
import 'package:app_news/view_models/login_view_model.dart';
import 'package:app_news/view_models/news_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'dart:convert';

import 'package:stacked/_viewmodel_builder.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  final NewsViewModel newsViewModel = NewsViewModel();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewsViewModel>.reactive(
      viewModelBuilder: () => newsViewModel,
      onModelReady: (model) => model.lihatData,
      builder: (context, model, child) {
        return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AddNews()));
              },
              child: Icon(
                Ionicons.md_add,
                color: ColorApp().lightPrimaryColor,
              ),
              backgroundColor: ColorApp().primaryColor,
            ),
            body: RefreshIndicator(
              onRefresh: () => model.lihatData,
              child: model.loading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: model.list.length,
                      itemBuilder: (context, i) {
                        final x = model.list[i];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsDetail(x),
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
                                        leading: Image.network(
                                          BaseUrl().insertNews + x.image,
                                          width: 100.0,
                                          height: 100.0,
                                          fit: BoxFit.cover,
                                        ),
                                        title: Text(
                                          x.title,
                                          softWrap: true,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              x.date_news,
                                              softWrap: true,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            InkWell(
                                              child: Icon(
                                                FontAwesome5.edit,
                                                color: Colors.lightBlue[300],
                                              ),
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditNews(
                                                            x,
                                                            () => model
                                                                .lihatData),
                                                  ),
                                                );
                                              },
                                            ),
                                            InkWell(
                                              child: Icon(
                                                FontAwesome5.trash_alt,
                                                color: Colors.red[300],
                                              ),
                                              onTap: () {
                                                model.delete(x.id_news);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 3.0),
                                  child: Divider(
                                    color: ColorApp().accentColor,
                                    height: 1,
                                    thickness: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
            ));
      },
    );
  }
}
