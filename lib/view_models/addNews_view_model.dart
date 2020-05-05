import 'dart:io';
import 'package:app_news/constant/constantFile.dart';
import 'package:app_news/view_models/stream.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/_base_viewmodels.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class AddNewsViewModel extends BaseViewModel {
  File _imageFile;
  get imageFile => _imageFile;
  String title, content, description, idUsers;

  final _key = new GlobalKey<FormState>();
  get key => _key;

  final FocusNode _titleFocus = FocusNode();
  final FocusNode _contentFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  get titleFocus => _titleFocus;
  get contentFocus => _contentFocus;
  get descriptionFocus => _descriptionFocus;

  bool _loading = false;
  get loading => _loading;

  bool _noImg = false;
  get chooseImg => _noImg;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    idUsers = preferences.getString("id_users");
    notifyListeners();
  }

  check({BuildContext context, @required VoidCallback reload}) {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      submit(
        reload: reload,
        context: context,
      );
    }
    notifyListeners();
  }

  _pilihGallery() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 1920, maxWidth: 1080);

    _imageFile = image;
    if (_imageFile != null) {
      _noImg = false;
    }
    notifyListeners();
  }

  get pilihGallery => () => _pilihGallery();

  submit({BuildContext context, @required VoidCallback reload}) async {
    try {
      var uri = Uri.parse(BaseUrl().addNews);
      var request = http.MultipartRequest("POST", uri);

      //--------------------------------------------------------------
      request.fields['title'] = title;
      request.fields['content'] = content;
      request.fields['description'] = description;
      request.fields['id_users'] = idUsers;

      
      

      if (_imageFile != null) {
        var stream =
            http.ByteStream(DelegatingStream.typed(_imageFile.openRead()));
        var length = await _imageFile.length();

        request.files.add(http.MultipartFile("image", stream, length,
            filename: path.basename(_imageFile.path)));

        _noImg = false;
        _loading = true;
        notifyListeners();

        var response = await request.send();

        if (response.statusCode > 2) {
          print("image Upload");
          reload();
          Navigator.pop(context);
          _loading = false;
        } else {
          print("image failed");
          _loading = false;
        }
      } else {
        _noImg = true;
      }
    } catch (e) {
      debugPrint("Error $e");
      _loading = false;
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
