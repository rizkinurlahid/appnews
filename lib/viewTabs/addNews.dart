import 'dart:convert';
import 'dart:io';
import 'package:app_news/constant/constantFile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:path/path.dart' as path;
import 'package:async/async.dart';

class AddNews extends StatefulWidget {
  @override
  _AddNewsState createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {
  File _imageFile;

  String title, content, description, id_users;

  final _key = new GlobalKey<FormState>();

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id_users = preferences.getString("id_users");
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      submit();
    }
  }

  _pilihGallery() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 1920, maxWidth: 1080);
    setState(() {
      _imageFile = image;
    });
  }

//  submit() async {
//    final response = await http.post(BaseUrl().addNews, body: {
//      "title": title,
//      "content": content,
//      "description": description,
//      "id_users": id_users,
//
//
//    });
//    final data = jsonDecode(response.body);
//    int value = data['value'];
//    String pesan = data['message'];
//    if (value == 1) {
//      print(pesan);
//      setState(() {
//        Navigator.pop(context);
//      });
//    } else {
//      print(print);
//    }
//  }

  submit() async {
    try {
      var stream =
          http.ByteStream(DelegatingStream.typed(_imageFile.openRead()));
      var length = await _imageFile.length();

      var uri = Uri.parse(BaseUrl().addNews);
      var request = http.MultipartRequest("POST", uri);
      request.files.add(http.MultipartFile("image", stream, length,
          filename: path.basename(_imageFile.path)));

      //--------------------------------------------------------------
      request.fields['title'] = title;
      request.fields['content'] = content;
      request.fields['description'] = description;
      request.fields['id_users'] = id_users;

      var response = await request.send();

      if (response.statusCode > 2) {
        print("image Upload");
        setState(() {
          Navigator.pop(context);
        });
      } else {
        print("image failed");
      }
    } catch (e) {
      debugPrint("Error $e");
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    var placeholder = Container(
      width: double.infinity,
      height: 150,
      child: Image.asset('./images/placeholder.png'),
    );
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _key,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            Container(
              width: double.infinity,
              child: InkWell(
                onTap: () {
                  _pilihGallery();
                },
                child: _imageFile == null
                    ? placeholder
                    : Image.file(
                        _imageFile,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
            TextFormField(
              onSaved: (e) => title = e,
              decoration: InputDecoration(labelText: 'title'),
            ),
            TextFormField(
              onSaved: (e) => content = e,
              decoration: InputDecoration(labelText: 'Content'),
            ),
            TextFormField(
              minLines: 15,
              maxLines: 31,
              onSaved: (e) => description = e,
              decoration: InputDecoration(labelText: 'description'),
            ),
            MaterialButton(
              onPressed: () {
                check();
              },
              child: Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
