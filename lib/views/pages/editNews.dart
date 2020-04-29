import 'package:app_news/constant/constantFile.dart';
import 'package:app_news/constant/newsModel.dart';
import 'package:app_news/utils/color.dart';
import 'package:app_news/view_models/editNews_view_model.dart';
import 'package:app_news/views/widgets/button.dart';
import 'package:app_news/views/widgets/textFieldDesign.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:stacked/_viewmodel_builder.dart';

class EditNews extends StatefulWidget {
  final NewsModel model;
  final VoidCallback reload;
  EditNews({this.model, this.reload});

  @override
  _EditNewsState createState() => _EditNewsState();
}

class _EditNewsState extends State<EditNews> {
  final EditNewsViewModel editNewsViewModel = EditNewsViewModel();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditNewsViewModel>.reactive(
      viewModelBuilder: () => editNewsViewModel,
      onModelReady: (model) => model.setup(
        title: widget.model.title,
        content: widget.model.content,
        description: widget.model.description,
      ),
      builder: (context, model, child) {
        final width = MediaQuery.of(context).size.width;
        return Scaffold(
          backgroundColor: ColorApp().bgColor,
          appBar: AppBar(
            title: Text("Edit News"),
          ),
          body: Form(
            key: model.key,
            child: ListView(
              padding: EdgeInsets.all(10.0),
              children: <Widget>[
                //3.2 Edit image
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
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorApp().accentColor,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      width: double.infinity,
                      child: InkWell(
                        onTap: () => model.pilihGallery(),
                        child: model.imageFile == null
                            ? Image.network(
                                BaseUrl().insertNews + widget.model.image)
                            : Image.file(
                                model.imageFile,
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFieldDesign(
                    controller: model.txtTitle,
                    onSaved: (e) => model.title = e,
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
                  controller: model.txtContent,
                  onSaved: (e) => model.content = e,
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFieldDesign(
                    controller: model.txtDescription,
                    onSaved: (e) => model.description = e,
                    maxLines: 5,
                    minLines: 5,
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
                ),
                DesignButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(FontAwesome5.save,
                          color: ColorApp().lightPrimaryColor),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        "Simpan",
                        style: TextStyle(color: ColorApp().lightPrimaryColor),
                      ),
                    ],
                  ),
                  press: () => model.check(
                    context: context,
                    reload: widget.reload,
                    idNews: widget.model.id_news,
                    image: widget.model.image,
                  ),
                  width: null,
                ),

                // MaterialButton(
                //   onPressed: () {
                //     model.check(
                //       context: context,
                //       reload: widget.reload,
                //       idNews: widget.model.id_news,
                //       image: widget.model.image,
                //     );
                //   },
                //   child: Text("Simpan"),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
