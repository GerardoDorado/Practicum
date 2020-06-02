import 'package:flutter/material.dart';
import 'package:practicum/src/bloc/provider.dart';
import 'package:practicum/src/busquedas/busqueda_alumno.dart';
import 'package:practicum/src/models/alumnos_models.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';
import 'package:practicum/src/widgets/menu_widget.dart';

class ConsultasAlumnos extends StatelessWidget {
  static final String routeName = 'alumnosConsulta';

  @override
  Widget build(BuildContext context) {
    final alumnosBloc = Provider.alumnosBloc(context);
    alumnosBloc.cargarAlumnos();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Estudiantes", style: TextStyle(color: Colors.blue)),
        iconTheme: new IconThemeData(color: Colors.blue),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: BusquedaAlumno(),
                // query: 'Hola'
              );
            },
          )
        ],
      ),
      drawer: MenuWidget(),
      body: _crearListado(alumnosBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado(AlumnosBloc alumnosBloc) {
    return StreamBuilder(
        stream: alumnosBloc.alumnosStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<AlumnoModel>> snapshot) {
          if (snapshot.hasData) {
            final alumnos = snapshot.data;

            return ListView.builder(
              itemCount: alumnos.length,
              itemBuilder: (context, i) =>
                  _crearItem(context, alumnosBloc, alumnos[i]),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _crearItem(
      BuildContext context, AlumnosBloc alumnosBloc, AlumnoModel alumno) {
    final _prefs = new PreferenciasUsuario();
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.black,
        child: Align(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
      onDismissed: (direccion) =>
          alumnosBloc.borrarAlumno(alumno.matricula.toString()),
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              /*
              leading: Container(
                padding: EdgeInsets.only(right: 12.0),
                decoration: new BoxDecoration(
                    border: new Border(
                        right:
                            new BorderSide(width: 1.0, color: Colors.black))),
                child: Icon(Icons.people_outline, color: Colors.blue),
              ),
              */
              leading: CircleAvatar(
                backgroundImage: NetworkImage('${ _prefs.direccionHost }/../uploads/users/${alumno.image}'),
              ),

              title: Text(
                '${alumno.nombre} ${alumno.primerAp} ${alumno.segundoAp}',
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${alumno.matricula} - ${alumno.licenciatura}'),
              onTap: () =>
                  Navigator.pushNamed(context, 'alumnos', arguments: alumno),
            )
          ],
        ),
      ),
    );
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.blue,
      onPressed: () => Navigator.pushNamed(context, 'alumnos'),
    );
  }
}
