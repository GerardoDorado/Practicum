import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practicum/src/widgets/menu_alumno.dart';
import 'dart:convert';
import 'dart:ui' as prefix0;
import 'package:http/http.dart' as http;

import 'package:practicum/src/animations/fadeanimation.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';


class AlumnosPrincipal extends StatefulWidget {
  static final String routeName = 'alumnos_principal';
  
  @override
  _PaginaPrincipalState createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<AlumnosPrincipal> {
  //static final String routeName = 'home_principal';
  //final principalProvider = new PrincipalProvider();
  final _prefs = new PreferenciasUsuario();
  Map<String, dynamic> principal = new Map();
  //cargarDatosPrincipal();

  cargarDatosPrincipal() async {
    final response = await http
        .get('${_prefs.direccionHost}/practicum_php/consultaPrincipal.php');

    if (response.statusCode == 200) {
      setState(() {
        print(principal);
        principal = json.decode(response.body);
        print(principal);
      });
    } else {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    //cargarDatosPrincipal();
    return Scaffold(
      //backgroundColor: Colors.grey[100],
      //backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text("Practicum", style: TextStyle(color: Colors.blue)),
        iconTheme: new IconThemeData(color: Colors.blue),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),

      //extendBodyBehindAppBar: true,
      //extendBody: true,
      drawer: MenuAlumnoWidget(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/hojas_de_papel.jpg'),
                    fit: BoxFit.cover),
              ),
              child: Container(
                decoration: BoxDecoration(
                    gradient:
                        LinearGradient(begin: Alignment.bottomRight, colors: [
                  Colors.black.withOpacity(.8),
                  Colors.black.withOpacity(.2),
                ])),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FadeAnimation(
                        1,
                        Text(
                          "Practicum",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                        1.3,
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 3),
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white,
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                                hintText: "Búscar estudiantes, docentes..."),
                          ),
                        )),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Text(
                        "Sistema de tutorías",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                            fontSize: 20),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                      1.4,
                      Container(
                        height: 200,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            makeItem(
                                image: 'assets/estudiante.jpg',
                                title: 'Desarrollo de habilidades'),
                            makeItem(
                                image: 'assets/utiles.jpg',
                                title: 'Desarrollo académico'),
                            makeItem(
                                image: 'assets/pincelez.jpeg',
                                title: 'Desarrollo creativo'),
                            makeItem(
                                image: 'assets/personas.jpg',
                                title:
                                    'Desarrollo en compentencias del día a día'),
                            makeItem(
                                image: 'assets/estudiantes.jpg',
                                title: 'Organización de tareas')
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                      1,
                      Text(
                        "Quienes somos...",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                            fontSize: 20),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                      1.4,
                      Container(
                        height: 200,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            makeItem(
                                image: 'assets/normal.jpg',
                                title: 'Escuela normal "Avila Camacho"'),
                            makeItem(
                                image: 'assets/personas.jpg',
                                title: 'Nuestros estudiantes'),
                            makeItem(
                                image: 'assets/estudiantes.jpg',
                                title: 'Nuestra organización de actividades'),
                            makeItem(
                                image: 'assets/estudiante.jpg',
                                title: 'Nuestras metas')
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Text(
                        "Usuarios",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                          fontSize: 20,
                        ),
                      )),
                  SizedBox(height: 20),
                  FadeAnimation(1, _botonesRedondeados(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget makeItem({image, title}) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: Container(
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.2),
              ])),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }

  //PrincipalModels principalModels = await principalProvider.cargarPrincipal();

  Widget _botonesRedondeados(BuildContext context) {
    // Map info = await usuarioProvider.login(bloc.identificador, bloc.password);
    //cargarDatosPrincipal()(
    //);
    //PrincipalModels principalModels ;
    //principal = principalProvider.cargarPrincipalMap() as Map<String, dynamic>;

    return Table(
      children: [
        TableRow(children: [
          _crearBotonRedondeado(Colors.blue, Icons.person_outline,
              "Alumnos:  ${principal['alumno']}"),
          _crearBotonRedondeado(Colors.purpleAccent, Icons.format_list_bulleted,
              "Licenciaturas:  ${principal['licenciatura']}"),
        ]),
        TableRow(children: [
          _crearBotonRedondeado(Colors.pinkAccent, Icons.people,
              "Docentes:  ${principal['maestro']}"),
          _crearBotonRedondeado(Colors.orange, Icons.perm_contact_calendar,
              "Tutores:  ${principal['tutores']}"),
        ]),
        TableRow(children: [
          _crearBotonRedondeado(Colors.blueAccent, Icons.assignment,
              "Plan de estudios:  ${principal['planEstudios']}"),
          _crearBotonRedondeado(
              Colors.green, Icons.cloud, "Usuarios:  ${principal['users']}"),
        ]),
        TableRow(children: [
          _crearBotonRedondeado(Colors.red, Icons.chrome_reader_mode, 'Archivos'),
          _crearBotonRedondeado(Colors.teal, Icons.help_outline, 'Ayuda'),
        ])
      ],
    );
  }

  Widget _crearBotonRedondeado(Color color, IconData icono, String texto) {
    return BackdropFilter(
      filter: prefix0.ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
      child: Container(
        height: 180.0,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: Color.fromRGBO(62, 66, 107, 0.7),
            borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(height: 5.0),
            CircleAvatar(
              backgroundColor: color,
              radius: 35.0,
              child: Icon(icono, color: Colors.white, size: 30.0),
            ),
            Text(texto, style: TextStyle(color: Colors.white)),
            SizedBox(height: 5.0)
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    cargarDatosPrincipal();
  }
}
