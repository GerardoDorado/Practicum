import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practicum/src/bloc/plan_accion_tutorial_bloc.dart';
import 'package:practicum/src/bloc/provider.dart';
import 'package:practicum/src/models/plan_accion_tutorial_models.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';
import 'package:practicum/src/widgets/menu_docente.dart';

class ConsultasPlanAccionTutorial extends StatelessWidget {
  static final String routeName = 'planAccionTutorialConsulta';

  @override
  Widget build(BuildContext context) {
    final planAccionTutorialBloc = Provider.planAccionTutorial(context);
    planAccionTutorialBloc.cargarplanAccionTutorial();

    return Scaffold(
      appBar: AppBar(
        title: Text("Plan acción tutorial", style: TextStyle(color: Colors.blue)),
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
      body: _crearListado(planAccionTutorialBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado(PlanAccionTutorialBloc planAccionTutorialBloc) {
    return StreamBuilder(
        stream: planAccionTutorialBloc.planAccionTutorialStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<PlanAccionTutorialModel>> snapshot) {
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
      BuildContext context, PlanAccionTutorialBloc planAccionTutorialBloc, PlanAccionTutorialModel planAccionTutorial) {
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
                backgroundImage: NetworkImage('${ _prefs.direccionHost }/../uploads/users/${planAccionTutorial.image}'),
              ),
              title: Text(
                '${planAccionTutorial.aspecto} ${planAccionTutorial.nombre}',
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${planAccionTutorial.nombre} ${planAccionTutorial.primerAp} ${planAccionTutorial.segundoAp}\n${planAccionTutorial.matricula}'),
              onTap: ()/* =>
                  Navigator.pushNamed(context, 'planAccionTutorial', arguments: planAccionTutorial),
            */
            {

            }
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
