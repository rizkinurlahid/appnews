import 'dart:io';
import 'package:app_news/constant/constantFile.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'package:async/async.dart';

class EditNewsViewModel extends BaseViewModel {
  final _key = new GlobalKey<FormState>();
  get key => _key;
  String title, content, description, idUsers;

  File _imageFile;
  get imageFile => _imageFile;

  TextEditingController _txtTitle, _txtContent, _txtDescription;
  get txtTitle => _txtTitle;
  get txtContent => _txtContent;
  get txtDescription => _txtDescription;

  final FocusNode _titleFocus = FocusNode();
  final FocusNode _contentFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  get titleFocus => _titleFocus;
  get contentFocus => _contentFocus;
  get descriptionFocus => _descriptionFocus;

  bool _loading = false;
  get loading => _loading;

  _pilihGallery() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 1920, maxWidth: 1080);

    _imageFile = image;
    notifyListeners();
  }

  get pilihGallery => () => _pilihGallery();

  setup({@required title, @required content, @required description}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    idUsers = preferences.getString("id_users");
    notifyListeners();

    _txtTitle = TextEditingController(text: title);
    _txtContent = TextEditingController(text: content);
    _txtDescription = TextEditingController(text: description);
    notifyListeners();
  }

  check(
      {@required idNews,
      @required VoidCallback reload,
      @required BuildContext context,
      @required String image}) {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      submit(
        idNews: idNews,
        reload: reload,
        context: context,
        image: image,
      );
    }
    notifyListeners();
  }

  submit(
      {@required idNews,
      @required VoidCallback reload,
      @required BuildContext context,
      @required String image}) async {
    //3.3 Edit gambar
    try {
      var uri = Uri.parse(BaseUrl().editNews);
      var request = http.MultipartRequest("POST", uri);

      //--------------------------------------------------------------
      request.fields['title'] = title;
      request.fields['content'] = content;
      request.fields['description'] = description;
      request.fields['id_users'] = idUsers;
      request.fields['id_news'] = idNews;

      _loading = true;
      notifyListeners();

      if (_imageFile != null) {
        var stream =
            http.ByteStream(DelegatingStream.typed(_imageFile.openRead()));

        var length = await _imageFile.length();

        request.files.add(http.MultipartFile("image", stream, length,
            filename: path.basename(_imageFile.path)));

        var response = await request.send();

        if (response.statusCode > 2) {
          print("image Upload");
          reload();
          _loading = false;

          Navigator.pop(context);
        } else {
          print("image failed");
          _loading = false;
        }
      } else {
        request.fields['gambar'] = image;
        var response = await request.send();

        if (response.statusCode > 2) {
          print("Updated");
          reload();
          Navigator.pop(context);
          _loading = false;

          print(_imageFile);
        } else {
          print("image failed");
          _loading = false;
        }
      }
    } catch (e) {
      debugPrint("Error $e");
    }
    notifyListeners();
  }

  fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
    notifyListeners();
  }
}
