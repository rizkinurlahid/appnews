// To parse this JSON data, do
//
//     final modelNews = modelNewsFromJson(jsonString);

import 'dart:convert';

ModelNews modelNewsFromJson(String str) => ModelNews.fromJson(json.decode(str));

String modelNewsToJson(ModelNews data) => json.encode(data.toJson());

class ModelNews {
  String status;
  int totalResults;
  List<Article> articles;

  ModelNews({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory ModelNews.fromJson(Map<String, dynamic> json) => ModelNews(
    status: json["status"] == null ? null : json["status"],
    totalResults: json["totalResults"] == null ? null : json["totalResults"],
    articles: json["articles"] == null ? null : List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "totalResults": totalResults == null ? null : totalResults,
    "articles": articles == null ? null : List<dynamic>.from(articles.map((x) => x.toJson())),
  };
}

class Article {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    source: json["source"] == null ? null : Source.fromJson(json["source"]),
    author: json["author"] == null ? null : json["author"],
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    url: json["url"] == null ? null : json["url"],
    urlToImage: json["urlToImage"] == null ? null : json["urlToImage"],
    publishedAt: json["publishedAt"] == null ? null : json["publishedAt"],
    content: json["content"] == null ? null : json["content"],
  );

  Map<String, dynamic> toJson() => {
    "source": source == null ? null : source.toJson(),
    "author": author == null ? null : author,
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "url": url == null ? null : url,
    "urlToImage": urlToImage == null ? null : urlToImage,
    "publishedAt": publishedAt == null ? null : publishedAt,
    "content": content == null ? null : content,
  };
}

class Source {
  String id;
  String name;

  Source({
    this.id,
    this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}
