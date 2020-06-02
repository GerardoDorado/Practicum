import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practicum/src/bloc/plan_estudios_bloc.dart';
import 'package:practicum/src/bloc/provider.dart';
import 'package:practicum/src/models/plan_estudios.dart';
import 'package:practicum/src/widgets/menu_widget.dart';

class ConsultasPlanEstudios extends StatelessWidget {
  static final String routeName = 'planEstudiosConsulta';

  @override
  Widget build(BuildContext context) {
    final planEstudiosBloc = Provider.planEstudiosBloc(context);
    planEstudiosBloc.cargarPlanEstudios();

    return Scaffold(
      appBar: AppBar(
        title: Text("Plan estudios", style: TextStyle(color: Colors.blue)),
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
      drawer: MenuWidget(),
      body: _crearListado(planEstudiosBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado(PlanEstudiosBloc planEstudiosBloc) {
    return StreamBuilder(
        stream: planEstudiosBloc.planEstudiosStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<PlanEstudiosModel>> snapshot) {
          if (snapshot.hasData) {
            final planEstudios = snapshot.data;

            return ListView.builder(
              itemCount: planEstudios.length,
              itemBuilder: (context, i) =>
                  _crearItem(context, planEstudiosBloc, planEstudios[i]),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _crearItem(
      BuildContext context, PlanEstudiosBloc planEstudiosBloc, PlanEstudiosModel planEstudios) {
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
              leading: Container(
                padding: EdgeInsets.only(right: 12.0),
                decoration: new BoxDecoration(
                    border: new Border(
                        right:
                            new BorderSide(width: 1.0, color: Colors.black))),
                child: Icon(Icons.poll, color: Colors.blue),
              ),
              title: Text(
                'Clave plan: ${planEstudios.idPlanEst}',
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${planEstudios.ano} - ${planEstudios.estado}'),
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
