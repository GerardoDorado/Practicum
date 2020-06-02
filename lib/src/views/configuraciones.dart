import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';
import 'package:practicum/src/widgets/menu_alumno.dart';
import 'package:practicum/src/widgets/menu_widget.dart';

class Configuraciones extends StatefulWidget {
  const Configuraciones({Key key}) : super(key: key);

  static final String routeName = 'configuraciones';
  @override
  _ConfiguracionesState createState() => _ConfiguracionesState();
}

class _ConfiguracionesState extends State<Configuraciones> {
  final _prefs = new PreferenciasUsuario();
  File _imageFile = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text("Configuraciones"),
        title: Text("Configuraciones", style: TextStyle(color: Colors.blue)),
        iconTheme: new IconThemeData(color: Colors.blue),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: () async => await _pickImageFromCamera(),
            tooltip: 'Camara',
          ),
          IconButton(
            icon: Icon(Icons.photo),
            onPressed: () async => await _pickImageFromGallery(),
            tooltip: 'Galeria',
          ),
          //this._imageFile == null ? Placeholder() : Image.file(this._imageFile),
        ],
      ),
      drawer: MenuWidget(),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          child: Column(
            children: <Widget>[
              this._imageFile == null ? Image(
                image: NetworkImage('${ _prefs.direccionHost }/../uploads/users/${ _prefs.image }'),
                //image: AssetImage('assets/loader_seq.gif'),
                //backgroundImage: NetworkImage('${ _prefs.direccionHost }/../uploads/users/${ _prefs.image }'),                

                height: 300.0,
                fit: BoxFit.cover,
              ): Image.file(this._imageFile),
            ],
          ),
        ),
      )),
    );
  }

  Widget _mostrarFoto() {
    if (_imageFile != null) {
      print(_imageFile.path);
      return FadeInImage(
        image: NetworkImage(_imageFile.path),
        placeholder: AssetImage('assets/loader_seq.gif'),
        height: 300.0,
        fit: BoxFit.contain,
      );
    } else {
      return Image(
        image: AssetImage(_imageFile?.path ?? 'assets/loader_seq.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }

  Future<Null> _pickImageFromGallery() async {
    final File imageFile =
        await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() => this._imageFile = imageFile);
  }

  Future<Null> _pickImageFromCamera() async {
    final File imageFile =
        await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() => this._imageFile = imageFile);
  }
}
