import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practicum/src/bloc/provider.dart';
import 'package:practicum/src/bloc/users_bloc.dart';
import 'package:practicum/src/models/users_models.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';
import 'package:practicum/src/widgets/menu_widget.dart';

class ConsultasUsuarios extends StatelessWidget {
  static final String routeName = 'usersConsulta';

  @override
  Widget build(BuildContext context) {
    final usuariosBloc = Provider.usuariosBloc(context);
    usuariosBloc.cargarUsuarios();

    return Scaffold(
      appBar: AppBar(
        title: Text("Usuarios", style: TextStyle(color: Colors.blue)),
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
      body: _crearListado(usuariosBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado(UsuariosBloc usuariosBloc) {
    return StreamBuilder(
        stream: usuariosBloc.usuariosStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<UsuariosModel>> snapshot) {
          if (snapshot.hasData) {
            final usuarios = snapshot.data;

            return ListView.builder(
              itemCount: usuarios.length,
              itemBuilder: (context, i) =>
                  _crearItem(context, usuariosBloc, usuarios[i]),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _crearItem(
      BuildContext context, UsuariosBloc usuariosBloc, UsuariosModel usuarios) {
    //print(usuarios.imagen);
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
      //onDismissed: (direccion) =>
          //tutoresBloc.borrarTutores(tutores.matricula.toString()),
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
                child: Icon(Icons.person_outline, color: Colors.blue),
              ),*/
              leading: CircleAvatar(
                backgroundImage: NetworkImage('${ _prefs.direccionHost }/../uploads/users/${ usuarios.imagen }'),
              ),
              title: Text(
                '${usuarios.name} - ${usuarios.username}',
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${usuarios.lastLogin}'),
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
