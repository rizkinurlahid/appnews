import 'dart:io';
import 'package:app_news/constant/constantFile.dart';
import 'package:app_news/constant/newsModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'package:async/async.dart';

class EditNews extends StatefulWidget {
  final NewsModel model;
  final VoidCallback reload;
  EditNews(this.model, this.reload);

  @override
  _EditNewsState createState() => _EditNewsState();
}

class _EditNewsState extends State<EditNews> {
  final _key = new GlobalKey<FormState>();
  String title, content, description, id_users;

  File _imageFile;

  _pilihGallery() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 1920, maxWidth: 1080);
    setState(() {
      _imageFile = image;
    });
  }

  TextEditingController txtTitle, txtContent, txtDescription;

  setup() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id_users = preferences.getString("id_users");
    });

    txtTitle = TextEditingController(text: widget.model.title);
    txtContent = TextEditingController(text: widget.model.content);
    txtDescription = TextEditingController(text: widget.model.description);
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      submit();
    } else {}
  }

  submit() async {
    //3.3 Edit gambar
    try {
      var uri = Uri.parse(BaseUrl().editNews);
      var request = http.MultipartRequest("POST", uri);

      //--------------------------------------------------------------
      request.fields['title'] = title;
      request.fields['content'] = content;
      request.fields['description'] = description;
      request.fields['id_users'] = id_users;
      request.fields['id_news'] = widget.model.id_news;

      var stream =
          http.ByteStream(DelegatingStream.typed(_imageFile.openRead()));
      var length = await _imageFile.length();

      request.files.add(http.MultipartFile("image", stream, length,
          filename: path.basename(_imageFile.path)));

      var response = await request.send();

      if (response.statusCode > 2) {
        print("image Upload");
        setState(() {
          widget.reload();
          Navigator.pop(context);
        });
      } else {
        print("image failed");
      }
    } catch (e) {
      debugPrint("Error $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _key,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            //3.2 Edit image
            Container(
              width: double.infinity,
              child: InkWell(
                onTap: () {
                  _pilihGallery();
                },
                child: _imageFile == null
                    ? Image.network(BaseUrl().insertNews + widget.model.image)
                    : Image.file(
                        _imageFile,
                        fit: BoxFit.fill,
                      ),
              ),
            ),

            TextFormField(
              //1.4 Parshing Data (memanggil
              controller: txtTitle,

              onSaved: (e) => title = e,
              decoration: InputDecoration(labelText: 'Title'),
            ),

            TextFormField(
              //1.5 Parshing Data (memanggil
              controller: txtContent,
              onSaved: (e) => content = e,
              decoration: InputDecoration(labelText: 'Content'),
            ),

            TextFormField(
              minLines: 10,
              maxLines: 31,
              controller: txtDescription,
              onSaved: (e) => description = e,
              decoration: InputDecoration(labelText: 'Description'),
            ),

            SizedBox(
              height: 5,
            ),

            MaterialButton(
              onPressed: () {
                check();
              },
              child: Text("Simpan"),
            )
          ],
        ),
      ),
    );
  }
}
