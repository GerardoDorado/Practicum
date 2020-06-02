import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practicum/src/bloc/asesorados_bloc.dart';
import 'package:practicum/src/bloc/provider.dart';
import 'package:practicum/src/models/asesorados_models.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';
import 'package:practicum/src/widgets/menu_docente.dart';

class ConsultasAsesorados extends StatelessWidget {
  static final String routeName = 'asesoradosConsulta';

  @override
  Widget build(BuildContext context) {
    final asesoradosBloc = Provider.asesoradosBloc(context);
    asesoradosBloc.cargarAsesorados();

    return Scaffold(
      appBar: AppBar(
        title: Text("Asesorados", style: TextStyle(color: Colors.blue)),
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
      body: _crearListado(asesoradosBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado(AsesoradosBloc asesoradosBloc) {
    return StreamBuilder(
        stream: asesoradosBloc.asesoradosStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<AsesoradosModel>> snapshot) {
          if (snapshot.hasData) {
            final asesorados = snapshot.data;

            return ListView.builder(
              itemCount: asesorados.length,
              itemBuilder: (context, i) =>
                  _crearItem(context, asesoradosBloc, asesorados[i]),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _crearItem(
      BuildContext context, AsesoradosBloc asesoradosBloc, AsesoradosModel asesorados) {
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
              /*
              leading: Container(
                padding: EdgeInsets.only(right: 12.0),
                decoration: new BoxDecoration(
                    border: new Border(
                        right:
                            new BorderSide(width: 1.0, color: Colors.black))),
                child: Icon(Icons.person, color: Colors.black),
              ),
              */
              leading: CircleAvatar(
                backgroundImage: NetworkImage('${ _prefs.direccionHost }/../uploads/users/${asesorados.image}'),
              ),
              title: Text(
                '${asesorados.nombre} ${asesorados.primerAp} ${asesorados.segundoAp}',
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${asesorados.matricula}'),
              onTap: () =>
                  Navigator.pushNamed(context, 'asesorados', arguments: asesorados),
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
