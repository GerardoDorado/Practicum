import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practicum/src/bloc/diagnostico_bloc.dart';
import 'package:practicum/src/bloc/provider.dart';
import 'package:practicum/src/models/diagnostico_models.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';
import 'package:practicum/src/widgets/menu_docente.dart';

class ConsultasDiagnostico extends StatelessWidget {
  static final String routeName = 'diagnosticoConsulta';

  @override
  Widget build(BuildContext context) {
    final diagnosticoBloc = Provider.diagnosticoBloc(context);
    diagnosticoBloc.cargarDiagnostico();

    return Scaffold(
      appBar: AppBar(
        title: Text("Diagnóstico", style: TextStyle(color: Colors.blue)),
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
      body: _crearListado(diagnosticoBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado(DiagnosticoBloc diagnosticoBloc) {
    return StreamBuilder(
        stream: diagnosticoBloc.diagnosticoStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<DiagnosticoModel>> snapshot) {
          if (snapshot.hasData) {
            final diagnostico = snapshot.data;

            return ListView.builder(
              itemCount: diagnostico.length,
              itemBuilder: (context, i) =>
                  _crearItem(context, diagnosticoBloc, diagnostico[i]),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _crearItem(
      BuildContext context, DiagnosticoBloc diagnosticoBloc, DiagnosticoModel diagnostico) {
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
                'Aspecto: ${diagnostico.aspecto}\nDebilidad: ${diagnostico.debilidad}\nEstrategia: ${diagnostico.estrategia}',
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${diagnostico.nombre} ${diagnostico.primerAp} ${diagnostico.segundoAp}\n${diagnostico.matricula}'),
              onTap: () =>
                  Navigator.pushNamed(context, 'diagnosticos', arguments: diagnostico),
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
      onPressed: () => Navigator.pushNamed(context, 'diagnosticos'),
    );
  }
}
