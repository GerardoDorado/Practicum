import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:practicum/src/paginas/Alumnos.dart';
import 'package:practicum/src/paginas/home_admin.dart';
import 'package:practicum/src/paginas/login.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';
import 'package:practicum/src/views/configuraciones.dart';
import 'package:practicum/src/views/consultas_alumnos.dart';
import 'package:practicum/src/views/consultas_docentes.dart';
import 'package:practicum/src/views/consultas_licenciaturas.dart';
import 'package:practicum/src/views/consultas_plan_estudios.dart';
import 'package:practicum/src/views/consultas_tutores.dart';
import 'package:practicum/src/views/consultas_user_groups.dart';
import 'package:practicum/src/views/consultas_users.dart';

class MenuWidget extends StatelessWidget {
  final _prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    //final bloc = Provider.of(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              //backgroundColor: Colors.white,
              /*child: Icon(
                Icons.people,
                size: 40,
                color: Colors.lightBlueAccent,
              ),*/
              backgroundImage: NetworkImage('${ _prefs.direccionHost }/../uploads/users/${ _prefs.image }'),
            ),
            accountName: Text(
              _prefs.nombreUsuario,
              style: TextStyle(fontSize: 20),
            ),
            accountEmail: Text(_prefs.username),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/image_fondo.png'),
                    fit: BoxFit.cover)),
          ),
          ListTile(
            leading: Icon(Icons.pages, color: Colors.blue),
            title: Text('Inicio'),
            onTap: () => Navigator.pushReplacementNamed(
                context, PaginaPrincipal.routeName),
          ),
          ListTile(
            leading: Icon(Icons.people_outline, color: Colors.blue),
            title: Text('Estudiantes'),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, ConsultasAlumnos.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.blue),
            title: Text('Profesores'),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, ConsultasDocentes.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.book, color: Colors.blue),
            title: Text('Licenciaturas'),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, ConsutasLicenciatura.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.event_available, color: Colors.blue),
            title: Text('Relación tutorial'),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, ConsultasTutores.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.poll, color: Colors.blue),
            title: Text('Plan de estudios'),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, ConsultasPlanEstudios.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.people, color: Colors.blue),
            title: Text('Grupos'),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, ConsultasUserGroups.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.person_outline, color: Colors.blue),
            title: Text('Usuarios'),
            onTap: () {
              Navigator.pushReplacementNamed(context, ConsultasUsuarios.routeName);
            },
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.settings, color: Colors.blue),
              title: Text('Configuraciones'),
              onTap: () {
                // Navigator.pop(context);
                Navigator.pushReplacementNamed(context, Configuraciones.routeName  );
              }),
          ListTile(
              leading: Icon(Icons.lock_outline, color: Colors.blue),
              title: Text('Cerrar cesión'),
              onTap: () {
                Navigator.pushReplacementNamed(context, Login.routeName);
              }),
        ],
      ),
    );
  }
}
