import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practicum/src/paginas/docentes.dart';
import 'package:practicum/src/paginas/login.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';
import 'package:practicum/src/views/consultas_asesorados.dart';
import 'package:practicum/src/views/consultas_diagnostico.dart';
import 'package:practicum/src/views/consultas_evaluacion_clase.dart';
import 'package:practicum/src/views/consultas_inducciones.dart';
import 'package:practicum/src/views/consultas_plan_accion_tutorial.dart';
import 'package:practicum/src/views/consultas_sessiones.dart';

class MenuDocenteWidget extends StatelessWidget {
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
              /*
              backgroundColor: Colors.white,
              child: Icon(
                Icons.people,
                size: 40,
                color: Colors.lightBlueAccent,
              ),
              */
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
                context, DocentesPrincipal.routeName),
          ),
          ListTile(
            leading: Icon(Icons.person_pin, color: Colors.blue),
            title: Text('Asesorados'),
            onTap: () => Navigator.pushReplacementNamed(
                context, ConsultasAsesorados.routeName),
          ),
          ListTile(
            leading: Icon(Icons.event_available, color: Colors.blue),
            title: Text('Plan acción tutorial'),
            onTap: () {
              Navigator.pushReplacementNamed(context, ConsultasPlanAccionTutorial.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.poll, color: Colors.blue),
            title: Text('Sessiones'),
            onTap: () {
              Navigator.pushReplacementNamed(context, ConsultasSessiones.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.people, color: Colors.blue),
            title: Text('Asesoría de titulación'),
            onTap: () {
              Navigator.pushReplacementNamed(context, ConsultasInducciones.routeName);
            },
          ),

          ListTile(
            leading: Icon(Icons.filter_list, color: Colors.blue),
            title: Text('Diagnóstico'),
            onTap: () {
              Navigator.pushReplacementNamed(context, ConsultasDiagnostico.routeName);
            },
          ),

          ListTile(
            leading: Icon(Icons.check_box_outline_blank, color: Colors.blue),
            title: Text('Tutoría professional'),
            onTap: () {
              Navigator.pushReplacementNamed(context, ConsultasEvaluacionClase.routeName);
            },
          ),

          Divider(),
          ListTile(
              leading: Icon(Icons.settings, color: Colors.blue),
              title: Text('Configuraciones'),
              onTap: () {
                // Navigator.pop(context);
                //Navigator.pushReplacementNamed(context, SettingsPage.routeName  );
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
