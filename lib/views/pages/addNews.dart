import 'package:app_news/utils/color.dart';
import 'package:app_news/view_models/addNews_view_model.dart';
import 'package:app_news/views/widgets/button.dart';
import 'package:app_news/views/widgets/placeHolder.dart';
import 'package:app_news/views/widgets/textFieldDesign.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:stacked/_viewmodel_builder.dart';

class AddNews extends StatefulWidget {
  final VoidCallback reload;
  AddNews({this.reload});
  @override
  _AddNewsState createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {
  final AddNewsViewModel addNewsViewModel = AddNewsViewModel();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddNewsViewModel>.reactive(
      viewModelBuilder: () => addNewsViewModel,
      onModelReady: (model) => model.getPref(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: ColorApp().bgColor,
          appBar: AppBar(
            title: Text("Add News"),
          ),
          body: Form(
            key: model.key,
            child: ListView(
              padding: EdgeInsets.all(10.0),
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesome5.image,
                            color: ColorApp().secondaryText,
                            size: 20.0,
                          ),
                          SizedBox(
                            width: 3.0,
                          ),
                          Text(
                            'Image :',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorApp().secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: <Widget>[
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          alignment: Alignment.bottomCenter,
                          height: (model.chooseImg) ? 180.0 : 150.0,
                          child: Text(
                            'No Image',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: (model.chooseImg)
                                  ? Colors.red
                                  : ColorApp().accentColor,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          width: double.infinity,
                          child: InkWell(
                            onTap: () => model.pilihGallery(),
                            child: model.imageFile == null
                                ? PlaceholderAddNews()
                                : Image.file(
                                    model.imageFile,
                                    fit: BoxFit.fill,
                                    height: 150.0,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFieldDesign(
                    onSaved: (e) => model.title = e,
                    maxLines: 3,
                    minLines: 3,
                    radius: 5.0,
                    colorLabel: ColorApp().secondaryText,
                    colorIcon: ColorApp().secondaryText,
                    colorText: ColorApp().secondaryText,
                    icon: FlutterIcons.format_title_mco,
                    textInputAction: TextInputAction.next,
                    labelText: 'Title',
                    validator: (p) {
                      return (p.isEmpty) ? "Please Insert Title" : null;
                    },
                    focusNode: model.titleFocus,
                    onFieldSubmitted: (term) {
                      model.fieldFocusChange(
                          context, model.titleFocus, model.contentFocus);
                    },
                  ),
                ),
                TextFieldDesign(
                  onSaved: (e) => model.description = e,
                  maxLines: 3,
                  minLines: 3,
                  radius: 5.0,
                  colorLabel: ColorApp().secondaryText,
                  colorIcon: ColorApp().secondaryText,
                  colorText: ColorApp().secondaryText,
                  icon: MaterialIcons.description,
                  textInputAction: TextInputAction.newline,
                  labelText: 'Description',
                  validator: (p) {
                    return (p.isEmpty) ? "Please Insert Description" : null;
                  },
                  focusNode: model.descriptionFocus,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFieldDesign(
                    onSaved: (e) => model.content = e,
                    maxLines: 15,
                    minLines: 15,
                    radius: 5.0,
                    colorLabel: ColorApp().secondaryText,
                    colorIcon: ColorApp().secondaryText,
                    colorText: ColorApp().secondaryText,
                    icon: MaterialCommunityIcons.content_save_edit,
                    textInputAction: TextInputAction.next,
                    labelText: 'Content',
                    validator: (p) {
                      return (p.isEmpty) ? "Please Insert Content" : null;
                    },
                    focusNode: model.contentFocus,
                    onFieldSubmitted: (term) {
                      model.fieldFocusChange(
                          context, model.contentFocus, model.descriptionFocus);
                    },
                  ),
                ),
                DesignButton(
                  child: (model.loading)
                      ? Center(
                          child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              ColorApp().lightPrimaryColor),
                        ))
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(FontAwesome5.save,
                                color: ColorApp().lightPrimaryColor),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              "Simpan",
                              style: TextStyle(
                                  color: ColorApp().lightPrimaryColor),
                            ),
                          ],
                        ),
                  press: () => model.check(
                    context: context,
                    reload: widget.reload,
                  ),
                  width: null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
