import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practicum/src/bloc/provider.dart';
import 'package:practicum/src/bloc/sessiones_bloc.dart';
import 'package:practicum/src/models/sessiones_models.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';
import 'package:practicum/src/widgets/menu_docente.dart';

class ConsultasSessiones extends StatelessWidget {
  static final String routeName = 'sessionesConsulta';

  @override
  Widget build(BuildContext context) {
    final sessionesBloc = Provider.sessionesBloc(context);
    sessionesBloc.cargarSessiones();

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
      drawer: MenuDocenteWidget(),
      body: _crearListado(sessionesBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado(SessionesBloc sessionesBloc) {
    return StreamBuilder(
        stream: sessionesBloc.sessionesStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<SessionesModel>> snapshot) {
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
      BuildContext context, SessionesBloc sessionesBloc, SessionesModel sessiones) {
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
              subtitle: Text('${sessiones.nombre} ${sessiones.primerAp} ${sessiones.segundoAp} \n ${sessiones.matricula}'),
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
      onPressed: () => Navigator.pushNamed(context, 'asesorados'),
    );
  }
}
