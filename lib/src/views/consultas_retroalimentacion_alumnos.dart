import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practicum/src/bloc/evaluacion_clase_bloc.dart';
import 'package:practicum/src/bloc/provider.dart';
import 'package:practicum/src/models/evaluacion_clase_models.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';
import 'package:practicum/src/widgets/menu_alumno.dart';

class ConsultasRetroalimentacionAlumno extends StatelessWidget {
  static final String routeName = 'retroalimentacionAlumnoConsulta';

  @override
  Widget build(BuildContext context) {
    final evaluacionClaseBloc = Provider.evaluacionClaseBloc(context);
    evaluacionClaseBloc.cargarEvaluacionClaseAlumno();

    return Scaffold(
      appBar: AppBar(
        title: Text("Retroalimentacion", style: TextStyle(color: Colors.blue)),
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
      body: _crearListado(evaluacionClaseBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado(EvaluacionClaseBloc evaluacionClaseBloc) {
    return StreamBuilder(
        stream: evaluacionClaseBloc.evaluacionClaseStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<EvaluacionClaseModel>> snapshot) {
          if (snapshot.hasData) {
            final evaluacionClase = snapshot.data;

            return ListView.builder(
              itemCount: evaluacionClase.length,
              itemBuilder: (context, i) =>
                  _crearItem(context, evaluacionClaseBloc, evaluacionClase[i]),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _crearItem(
      BuildContext context, EvaluacionClaseBloc evaluacionClaseBloc, EvaluacionClaseModel evaluacionClase) {
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
                'Aspectos: ${evaluacionClase.aspectos}\nAtención: ${evaluacionClase.atencion}\nFortalezas:${evaluacionClase.fortaleza}\nFormas:${evaluacionClase.formas}',
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${evaluacionClase.nombre} ${evaluacionClase.primerAp} ${evaluacionClase.segundoAp}\nFecha: ${evaluacionClase.fecha}'),
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
