import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practicum/src/bloc/inducciones_alumnos_bloc.dart';
import 'package:practicum/src/bloc/provider.dart';
import 'package:practicum/src/models/inducciones_alumnos_models.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';
import 'package:practicum/src/widgets/menu_alumno.dart';

class ConsultasInduccionesAlumno extends StatelessWidget {
  static final String routeName = 'induccionesAlumnoConsulta';

  @override
  Widget build(BuildContext context) {
    final induccionesBloc = Provider.induccionesAlumnosBloc(context);
    induccionesBloc.cargarInduccionesAlumnos();

    return Scaffold(
      appBar: AppBar(
        title: Text("Inducción", style: TextStyle(color: Colors.blue)),
        iconTheme: new IconThemeData(color: Colors.blue),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      drawer: MenuAlumnoWidget(),
      body: _crearListado(induccionesBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado(InduccionesAlumnosBloc induccionesBloc) {
    return StreamBuilder(
        stream: induccionesBloc.induccionesStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<InduccionesAlumnosModels>> snapshot) {
          if (snapshot.hasData) {
            final inducciones = snapshot.data;

            return ListView.builder(
              itemCount: inducciones.length,
              itemBuilder: (context, i) =>
                  _crearItem(context, induccionesBloc, inducciones[i]),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _crearItem(
      BuildContext context, InduccionesAlumnosBloc induccionesBloc, InduccionesAlumnosModels inducciones) {
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
      //onDismissed: (direccion) =>
          //tutoresBloc.borrarTutores(tutores.matricula.toString()),
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: CircleAvatar(
                backgroundImage: NetworkImage('${ _prefs.direccionHost }/../uploads/users/no_image.jpg'),
              ),
              title: Text(
                'Proyecto: ${inducciones.nombre}\nModalidad de titulación: ${inducciones.modalidad}',
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Tematica: ${inducciones.tematica}'),
              onTap: (){} //=>
                  //Navigator.pushNamed(context, 'tutores', arguments: tutores),
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
      onPressed: (){} //=> Navigator.pushNamed(context, 'tutores'),
    );
  }
}
