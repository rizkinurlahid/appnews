import 'dart:convert';
import 'package:app_news/constant/constantFile.dart';
import 'package:app_news/constant/newsModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'newsDetail.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final list = new List<NewsModel>();
  var loading = false;

  Future _lihatData() async {
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.get(BaseUrl().detailNews);

    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new NewsModel(
          api['id_news'],
          api['image'],
          api['title'],
          api['content'],
          api['description'],
          api['date_news'],
          api['id_users'],
          api['username'],
        );
        list.add(ab);
      });
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lihatData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          _lihatData();
        },
        child: loading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Stories",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    height: 200,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: (context, i) {
                          final x = list[i];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewsDetail(x)));
                            },
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      BaseUrl().insertNews + x.image,
                                      fit: BoxFit.fill,
                                      width: 400,
                                      height: 300,
                                    ),
                                  ),
                                ),

                                Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                      margin: EdgeInsets.all(16),
                                      width: 120,
                                      child: Text(
                                        x.title,
                                        style: TextStyle(
                                            color: Colors.black,
                                            backgroundColor: Colors.white),
                                      )),
                                ),

//                                Container(
//                                  width: MediaQuery.of(context).size.width,
//                                  padding: EdgeInsets.all(10),
//                                  child: Row(
//                                    crossAxisAlignment: CrossAxisAlignment.start,
//                                    children: <Widget>[
//                                      Container(
//                                        child: ClipRRect(
//                                          borderRadius: BorderRadius.circular(8),
//                                          child: Image.network(
//                                            BaseUrl().insertNews + x.image,
//                                            width: 150.0,
//                                            height: 120.0,
//                                            fit: BoxFit.cover,
//                                          ),
//                                        ),
//                                      ),
//                                      SizedBox(
//                                        width: 10,
//                                      ),
//                                      Expanded(
//                                        child: Column(
//                                          crossAxisAlignment: CrossAxisAlignment.start,
//                                          children: <Widget>[
//                                            Text(
//                                              x.title,
//                                              style: TextStyle(
//                                                  fontSize: 18,
//                                                  fontWeight: FontWeight.bold),
//                                            ),
//                                            Text(x.date_news),
//
//                                          ],
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Headline",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                  ),
                  ListView.builder(
                      itemCount: list.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        final x = list[i];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewsDetail(x)));
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        BaseUrl().insertNews + x.image,
                                        width: 150.0,
                                        height: 120.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            x.title,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(x.date_news),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(x.content),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                flex: 5,
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(Icons.access_time),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text("4 hr"),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      "| US & Canada",
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Divider(
                                  color: Colors.pink,
                                  height: 1,
                                  thickness: 2,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              ),
      ),
    );
  }
}
