import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practicum/src/bloc/inducciones_bloc.dart';
import 'package:practicum/src/bloc/provider.dart';
import 'package:practicum/src/models/inducciones_models.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';
import 'package:practicum/src/widgets/menu_docente.dart';

class ConsultasInducciones extends StatelessWidget {
  static final String routeName = 'induccionesConsulta';

  @override
  Widget build(BuildContext context) {
    final induccionesBloc = Provider.induccionesBloc(context);
    induccionesBloc.cargarInducciones();

    return Scaffold(
      appBar: AppBar(
        title: Text("Inducciones", style: TextStyle(color: Colors.blue)),
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
      drawer: MenuDocenteWidget(),
      body: _crearListado(induccionesBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado(InduccionesBloc induccionesBloc) {
    return StreamBuilder(
        stream: induccionesBloc.induccionesStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<InduccionesModel>> snapshot) {
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
      BuildContext context, InduccionesBloc induccionesBloc, InduccionesModel inducciones) {
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
                'Proyecto: ${inducciones.proyecto}\nEvaluación: ${inducciones.evaluacion}',
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${inducciones.nombre} ${inducciones.primerAp} ${inducciones.segundoAp}\n${inducciones.matricula}'),
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
