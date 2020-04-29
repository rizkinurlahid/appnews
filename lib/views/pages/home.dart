import 'package:app_news/utils/color.dart';
import 'package:app_news/constant/constantFile.dart';
import 'package:app_news/viewTabs/newsDetail.dart';
import 'package:app_news/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/_viewmodel_builder.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeViewModel homeViewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => homeViewModel,
      onModelReady: (model) => model.lihatData,
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
                : ListView(
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
                                      builder: (context) => NewsDetail(x)),
                                );
                              },
                              child: Stack(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
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
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5.0),
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
                            final x = model.list[i];
                            return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NewsDetail(x)));
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            x.content,
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
                                            x.date_news,
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
                                ));
                          }),
                    ],
                  ),
          ),
        );
      },
    );
  }
}

// Container(
//                             padding: EdgeInsets.all(10),
//                             child: Column(
//                               children: <Widget>[
//                                 Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     ClipRRect(
//                                       borderRadius: BorderRadius.circular(8),
//                                       child: Image.network(
//                                         BaseUrl().insertNews + x.image,
//                                         width: 150.0,
//                                         height: 120.0,
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: <Widget>[
//                                           Text(
//                                             x.title,
//                                             style: TextStyle(
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                           SizedBox(
//                                             height: 5,
//                                           ),
//                                           Text(x.date_news),
//                                           SizedBox(
//                                             height: 5,
//                                           ),
//                                           Text(x.content),
//                                           SizedBox(
//                                             height: 10,
//                                           ),
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: <Widget>[
//                                               Flexible(
//                                                 flex: 5,
//                                                 child: Row(
//                                                   children: <Widget>[
//                                                     Icon(Icons.access_time),
//                                                     SizedBox(
//                                                       width: 4,
//                                                     ),
//                                                     Text("4 hr"),
//                                                     SizedBox(
//                                                       width: 4,
//                                                     ),
//                                                     Text(
//                                                       "| US & Canada",
//                                                       style: TextStyle(
//                                                           color: Colors.red),
//                                                     )
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 8,
//                                 ),
//                                 Divider(
//                                   color: Colors.pink,
//                                   height: 1,
//                                   thickness: 2,
//                                 ),
//                               ],
//                             ),
//                           ),
