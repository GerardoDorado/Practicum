import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practicum/src/bloc/provider.dart';
import 'package:practicum/src/bloc/sessiones_alumnos_bloc.dart';
import 'package:practicum/src/models/sessiones_alumnos_models.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';
import 'package:practicum/src/widgets/menu_alumno.dart';

class ConsultasSessionesAlumnos extends StatelessWidget {
  static final String routeName = 'sessionesAlumnosConsulta';

  @override
  Widget build(BuildContext context) {
    final sessionesBloc = Provider.sessionesAlumnosBloc(context);
    sessionesBloc.cargarSessionesAlumnos();

    return Scaffold(
      appBar: AppBar(
        title: Text("Sessiones", style: TextStyle(color: Colors.blue)),
        iconTheme: new IconThemeData(color: Colors.blue),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
            },
          )
        ],
      ),
      drawer: MenuAlumnoWidget(),
      body: _crearListado(sessionesBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado(SessionesAlumnosBloc sessionesBloc) {
    return StreamBuilder(
        stream: sessionesBloc.sessionesStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<SessionesAlumnosModels>> snapshot) {
          if (snapshot.hasData) {
            final sessiones = snapshot.data;

            return ListView.builder(
              itemCount: sessiones.length,
              itemBuilder: (context, i) =>
                  _crearItem(context, sessionesBloc, sessiones[i]),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _crearItem(
      BuildContext context, SessionesAlumnosBloc sessionesBloc, SessionesAlumnosModels sessiones) {
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
                'Proposito: ${sessiones.proposito}\nAcuerdos: ${sessiones.acuerdos}',
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${sessiones.nombre} ${sessiones.primerAp} ${sessiones.segundoAp}\n${sessiones.id}'),
              onTap: () =>
                  Navigator.pushNamed(context, 'sessiones', arguments: sessiones),
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
      onPressed: (){

      },
      //onPressed: () => Navigator.pushNamed(context, 'asesorados'),
    );
  }
}
