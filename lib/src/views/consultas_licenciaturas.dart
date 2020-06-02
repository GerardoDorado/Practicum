import 'package:flutter/material.dart';
import 'package:practicum/src/bloc/licenciaturas_bloc.dart';
import 'package:practicum/src/bloc/provider.dart';
import 'package:practicum/src/models/licenciaturas_models.dart';
import 'package:practicum/src/widgets/menu_widget.dart';

class ConsutasLicenciatura extends StatelessWidget {
  static final String routeName = 'licenciaturasConsulta';

  @override
  Widget build(BuildContext context) {
    final licenciaturasBloc = Provider.licenciaturasBloc(context);
    licenciaturasBloc.cargarLicenciaturas();

    return Scaffold(
      appBar: AppBar(
        title: Text("Licenciaturas", style: TextStyle(color: Colors.blue)),
        iconTheme: new IconThemeData(color: Colors.blue),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      drawer: MenuWidget(),
      body: _crearListado(licenciaturasBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado(LicenciaturasBloc licenciaturasBloc) {
    return StreamBuilder(
        stream: licenciaturasBloc.licenciaturasStream,
        builder: (BuildContext context,
            AsyncSnapshot<List<LicenciaturaModel>> snapshot) {
          if (snapshot.hasData) {
            final licenciaturas = snapshot.data;

            return ListView.builder(
              itemCount: licenciaturas.length,
              itemBuilder: (context, i) =>
                  _crearItem(context, licenciaturasBloc, licenciaturas[i]),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _crearItem(BuildContext context, LicenciaturasBloc licenciaturasBloc,
      LicenciaturaModel licenciatura) {
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
      onDismissed: (direccion) => licenciaturasBloc
          .borrarLicenciatura(licenciatura.claveLic.toString()),
      child: Card(
        //elevation: 15.0,
        //shape:
        //    RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
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
                child: Icon(Icons.book, color: Colors.blue),
              ),
              title: Text(
                '${licenciatura.nombre}',
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${licenciatura.claveLic}'),
              onTap: () => Navigator.pushNamed(context, 'licenciatura',
                  arguments: licenciatura),
            ),
            /*
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text('Cancelar'),
                  onPressed: () {},
                ),
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {},
                )
              ],
            )*/
          ],
        ),
      ),
    );
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.blue,
      onPressed: () => Navigator.pushNamed(context, 'licenciatura'),
    );
  }
}
