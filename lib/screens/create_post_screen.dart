import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:trueke/utilities/constants.dart';

class CreatePostScreen extends StatefulWidget {
  CreatePostScreen({Key key}) : super(key: key);

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  List<File> _images = [];

  bool _isPickedFile = false;
  bool _isPhotoFile = false;

  int _index = 0;
  File digitalFile;
  PlatformFile tmpFile;
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _titleController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();

  String condition = "Nuevo";
  String category = "Tecnología";

  @override
  void initState() {
    _images.add(null);
    super.initState();
  }

  Future getFileFromDevice() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png'],
        allowMultiple: false);

    if (result != null) {
      setState(() {
        tmpFile = result.files.first;
        digitalFile = File(tmpFile.path);
        _isPickedFile = true;
      });
    }
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.camera, maxHeight: 460, maxWidth: 580);

    setState(() {
      _isPhotoFile = true;
      _images[_index] = File(pickedFile.path);
      _index++;
      _images.add(null);
    });
  }

  Future<List<int>> _readImageData() async {
    return _images[0].readAsBytes();
  }

  Future _storePickedFile() async {
    if (tmpFile.extension == "pdf") {
      //_uploadFile(digitalFile);
    } else {
      Uint8List imageData = digitalFile.readAsBytesSync();
      Directory directory = await getExternalStorageDirectory();
    }
  }

  Future _storePost() async {
    Dio dio = new Dio();
    dio.options.connectTimeout = 50000; //5s
    dio.options.receiveTimeout = 30000;
    dio.options.contentType = 'multipart/form-data';

    FormData formData = FormData.fromMap({
      'files[]': _images,
      'userId': settings.userId,
      'title': _titleController.text,
      'description': _descriptionController.text,
      'condition': condition,
      'category': category
    });

    dio.post('$serverHost/post', data: formData).then((value){
        print(value.data.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Nueva Publicación"), actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                if (!_isPickedFile && !_isPhotoFile) {
                  EasyLoading.showError("No hay imágenes que subir");
                } else {
                  EasyLoading.show(status: "Creando publicación. . .");
                  _storePost();
                  EasyLoading.dismiss();
                }
              })
        ]),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF73AEF5),
                          Color(0xFF61A4F1),
                          Color(0xFF478DE0),
                          Color(0xFF398AE5),
                        ],
                        stops: [0.1, 0.4, 0.7, 0.9],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    padding: EdgeInsets.all(20.0),
                    physics: ScrollPhysics(),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildTitleF(),
                          SizedBox(height: 15),
                          _buildTDescriptionTF(),
                          SizedBox(height: 15),
                          _buildConditionDropDown(),
                          SizedBox(height: 15),
                          _buildCategoryDropDown(),
                          SizedBox(height: 15),
                          Visibility(
                            visible: !_isPickedFile,
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _images.length,
                                itemBuilder: (c, i) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 15),
                                    child: Card(
                                      child: _images[i] == null
                                          ? InkWell(
                                          onTap: getImage,
                                          child: Container(
                                              height: 250,
                                              child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Icon(Icons.camera,
                                                        size: 70,
                                                        color: Colors.grey[600]),
                                                    Text("Tomar foto",
                                                        style: TextStyle(
                                                            fontSize: 30))
                                                  ])))
                                          : Image.file(_images[i], fit: BoxFit.cover),
                                    ),
                                  );
                                }),
                          )
                        ])
                  )
            ]
            ),
          ),
        )
    );
  }

  Widget _buildTitleF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Título',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _titleController,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.text_fields,
                color: Colors.white,
              ),
              hintText: 'Ingrese el título',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTDescriptionTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Descripción',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _descriptionController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.description,
                color: Colors.white,
              ),
              hintText: 'Ingrese descripción del producto',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConditionDropDown() {
    return Row(
      children: <Widget>[
        Expanded(
            child: DropdownButtonFormField(
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.precision_manufacturing_outlined,
                    color: Colors.white,
                  ),
                  hintText: 'Condición del producto',
                  hintStyle: kHintTextStyle,
                ),
                hint: Text('Condición'),
                isExpanded: true,
                value: "Nuevo",
                items: [
                  "Nuevo",
                  "Seminuevo",
                  "Usado",
                  "Reacondicionado"
                ].map((String category) {
                  return DropdownMenuItem(
                      value: category,
                      child: Row(children: <Widget>[Text(category)]));
                }).toList(),
                onChanged: (value) => condition = value,
                onSaved: (value) => condition = value
            )
        )
      ],
    );
  }

  Widget _buildCategoryDropDown() {
    return Row(
      children: <Widget>[
        Expanded(
            child: DropdownButtonFormField(
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.category,
                    color: Colors.white,
                  ),
                  hintText: 'Categoría',
                  hintStyle: kHintTextStyle,
                ),
                hint: Text('Categoría'),
                isExpanded: true,
                value: "Tecnología",
                items: [
                  "Tecnología",
                  "Juguetes",
                  "Videojuegos",
                  "Vehículos",
                  "Telefonía"
                ].map((String category) {
                  return DropdownMenuItem(
                      value: category,
                      child: Row(children: <Widget>[Text(category)]));
                }).toList(),
                onChanged: (value) => category = value,
                onSaved: (value) => category = value
            )
        )
      ],
    );
  }
}
