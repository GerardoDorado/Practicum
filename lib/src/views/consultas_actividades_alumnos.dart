import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practicum/src/bloc/actividades_bloc.dart';
import 'package:practicum/src/bloc/provider.dart';
import 'package:practicum/src/models/actividades_models.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';
import 'package:practicum/src/widgets/menu_alumno.dart';

class ConsultasPlanAccionTutorialActividades extends StatelessWidget {
  static final String routeName = 'actividadesConsulta';

  @override
  Widget build(BuildContext context) {
    final planAccionTutorialBloc = Provider.actividadesBloc(context);
    planAccionTutorialBloc.cargarplanAccionTutorialAlumnos();

    return Scaffold(
      appBar: AppBar(
        title: Text("Actividades", style: TextStyle(color: Colors.blue)),
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
      body: _crearListado(planAccionTutorialBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado(ActividadesBloc planAccionTutorialBloc) {
    return StreamBuilder(
        stream: planAccionTutorialBloc.actividadesStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<ActividadesModels>> snapshot) {
          if (snapshot.hasData) {
            final planAccionTutorial = snapshot.data;

            return ListView.builder(
              itemCount: planAccionTutorial.length,
              itemBuilder: (context, i) =>
                  _crearItem(context, planAccionTutorialBloc, planAccionTutorial[i]),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _crearItem(
      BuildContext context, ActividadesBloc planAccionTutorialBloc, ActividadesModels planAccionTutorial) {
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
                '${planAccionTutorial.actividad}\n${planAccionTutorial.fecha}',
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${planAccionTutorial.nombre} ${planAccionTutorial.primerAp} ${planAccionTutorial.segundoAp}'),
              onTap: () =>
                  Navigator.pushNamed(context, 'planAccionTutorial', arguments: planAccionTutorial),
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
