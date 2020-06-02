import 'package:flutter/material.dart';
import 'package:practicum/src/bloc/docentes_bloc.dart';
import 'package:practicum/src/bloc/provider.dart';
import 'package:practicum/src/busquedas/busqueda_docente.dart';
import 'package:practicum/src/models/docentes_models.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';
import 'package:practicum/src/widgets/menu_widget.dart';

class ConsultasDocentes extends StatelessWidget {
  static final String routeName = 'docentesConsulta';

  @override
  Widget build(BuildContext context) {
    final docentesBloc = Provider.docentesBloc(context);
    docentesBloc.cargarDocentes();

    return Scaffold(
      appBar: AppBar(
        title: Text("Profesores", style: TextStyle(color: Colors.blue)),
        iconTheme: new IconThemeData(color: Colors.blue),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: BusquedaDocente(),
                // query: 'Hola'
              );
            },
          )
        ],
      ),
      drawer: MenuWidget(),
      body: _crearListado(docentesBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado(DocentesBloc docentesBloc) {
    return StreamBuilder(
        stream: docentesBloc.docentesStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<DocenteModel>> snapshot) {
          if (snapshot.hasData) {
            final docentes = snapshot.data;

            return ListView.builder(
              itemCount: docentes.length,
              itemBuilder: (context, i) =>
                  _crearItem(context, docentesBloc, docentes[i]),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _crearItem(
      BuildContext context, DocentesBloc docentesBloc, DocenteModel docente) {
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
      onDismissed: (direccion) => docentesBloc.borrarDocente(docente.claveD),
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              /*leading: Container(
                padding: EdgeInsets.only(right: 12.0),
                decoration: new BoxDecoration(
                    border: new Border(
                        right:
                            new BorderSide(width: 1.0, color: Colors.black))),
                child: Icon(Icons.person, color: Colors.blue),
              ),*/
              leading: CircleAvatar(
                backgroundImage: NetworkImage('${ _prefs.direccionHost }/../uploads/users/${docente.image}'),
              ),
              title: Text(
                '${docente.nombre} ${docente.primerAp} ${docente.segundoAp}',
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${docente.claveD} - ${docente.gradoAc}'),
              onTap: () =>
                  Navigator.pushNamed(context, 'docentes', arguments: docente),
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
      onPressed: () => Navigator.pushNamed(context, 'docentes'),
    );
  }
}
