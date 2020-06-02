import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practicum/src/bloc/provider.dart';
import 'package:practicum/src/bloc/tutores_bloc.dart';
import 'package:practicum/src/models/tutores_models.dart';
import 'package:practicum/src/widgets/menu_widget.dart';

class ConsultasTutores extends StatelessWidget {
  static final String routeName = 'tutoresConsulta';

  @override
  Widget build(BuildContext context) {
    final tutoresBloc = Provider.tutoresBloc(context);
    tutoresBloc.cargarTutores();

    return Scaffold(
      appBar: AppBar(
        title: Text("Tutores", style: TextStyle(color: Colors.blue)),
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
      body: _crearListado(tutoresBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado(TutoresBloc tutoresBloc) {
    return StreamBuilder(
        stream: tutoresBloc.tutoresStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<TutoresModel>> snapshot) {
          if (snapshot.hasData) {
            final tutores = snapshot.data;

            return ListView.builder(
              itemCount: tutores.length,
              itemBuilder: (context, i) =>
                  _crearItem(context, tutoresBloc, tutores[i]),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _crearItem(
      BuildContext context, TutoresBloc tutoresBloc, TutoresModel tutores) {
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
                child: Icon(Icons.event_available, color: Colors.blue),
              ),
              title: Text(
                '${tutores.docente}  ${tutores.primerAp} ${tutores.segundoAp}',
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${tutores.claveD} - ${tutores.gradoAc}'),
              onTap: (){} //=>
                  //Navigator.pushNamed(context, 'tutores', arguments: tutores),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text('Agregar tutorado'),
                  onPressed: () => Navigator.pushNamed(context, 'altasTutores'),
                ),
                FlatButton(
                  child: Text('Administrar tutorados'),
                  onPressed: () {
                    Navigator.pushNamed(context, 'consultaTutorados', arguments: tutores.claveD);
                  },
                )
              ],
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
