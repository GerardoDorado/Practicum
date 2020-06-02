import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practicum/src/bloc/provider.dart';
import 'package:practicum/src/bloc/user_groups_bloc.dart';
import 'package:practicum/src/models/user_groups_models.dart';
import 'package:practicum/src/widgets/menu_widget.dart';

class ConsultasUserGroups extends StatelessWidget {
  static final String routeName = 'userGroupsConsulta';

  @override
  Widget build(BuildContext context) {
    final userGroupsBloc = Provider.userGroupsBloc(context);
    userGroupsBloc.cargarGrupos();

    return Scaffold(
      appBar: AppBar(
        title: Text("Grupos", style: TextStyle(color: Colors.blue)),
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
      body: _crearListado(userGroupsBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado(UserGroupsBloc userGroupsBloc) {
    return StreamBuilder(
        stream: userGroupsBloc.gruposStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<GruposModel>> snapshot) {
          if (snapshot.hasData) {
            final grupos = snapshot.data;

            return ListView.builder(
              itemCount: grupos.length,
              itemBuilder: (context, i) =>
                  _crearItem(context, userGroupsBloc, grupos[i]),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _crearItem(
      BuildContext context, UserGroupsBloc userGroupsBloc, GruposModel grupos) {
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
                child: Icon(Icons.people, color: Colors.blue),
              ),
              title: Text(
                '${grupos.groupName} ',
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${grupos.id} - Nivel: ${grupos.groupLevel}'),
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
