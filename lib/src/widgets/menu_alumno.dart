import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practicum/src/paginas/login.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';
import 'package:practicum/src/paginas/Alumnos.dart';
import 'package:practicum/src/views/consultas_actividades_alumnos.dart';
import 'package:practicum/src/views/consultas_diagnosticos_alumnos.dart';
import 'package:practicum/src/views/consultas_evaluacion_clase_alumno.dart';
import 'package:practicum/src/views/consultas_evaluacion_final_alumnos.dart';
import 'package:practicum/src/views/consultas_inducciones_alumnos.dart';
import 'package:practicum/src/views/consultas_reflexion_alumnos.dart';
import 'package:practicum/src/views/consultas_retroalimentacion_alumnos.dart';
import 'package:practicum/src/views/consultas_sessiones_alumnos.dart';

class MenuAlumnoWidget extends StatelessWidget {
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
                context, AlumnosPrincipal.routeName),
          ),
          ListTile(
            leading: Icon(Icons.event_available, color: Colors.blue),
            title: Text('Plan de acción tutorial'),
            onTap: () {
              Navigator.pushReplacementNamed(context, ConsultasPlanAccionTutorialActividades.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.poll, color: Colors.blue),
            title: Text('Sessiones'),
            onTap: () {
              Navigator.pushReplacementNamed(context, ConsultasSessionesAlumnos.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.people, color: Colors.blue),
            title: Text('Asesoría de titulación'),
            onTap: () {
              Navigator.pushReplacementNamed(context, ConsultasEvaluacionFinalAlumno.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.check_circle_outline, color: Colors.blue),
            title: Text('Retroalimentación'),
            onTap: () {
              Navigator.pushReplacementNamed(context, ConsultasRetroalimentacionAlumno.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.filter_list, color: Colors.blue),
            title: Text('Reflexión'),
            onTap: () {
              Navigator.pushReplacementNamed(context, ConsultasReflexionAlumno.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.tab, color: Colors.blue),
            title: Text('Inducción'),
            onTap: () {
              Navigator.pushReplacementNamed(context, ConsultasInduccionesAlumno.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.chevron_right, color: Colors.blue),
            title: Text('Diagnóstico'),
            onTap: () {
              Navigator.pushReplacementNamed(context, ConsultasDiagnosticosAlumnos.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.check_box_outline_blank, color: Colors.blue),
            title: Text('Tutoría professional'),
            onTap: () {
              Navigator.pushReplacementNamed(context, ConsultasEvaluacionClaseAlumno.routeName);
            },
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.settings, color: Colors.blue),
              title: Text('Configuraciones'),
              onTap: () {
                // Navigator.pop(context);
                //Navigator.pushReplacementNamed(context, Configuraciones.routeName  );
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
