import 'package:flutter/material.dart';
import 'package:practicum/src/bloc/login_bloc.dart';
import 'package:practicum/src/bloc/provider.dart';
import 'package:practicum/src/providers/usuarios_provider.dart';
import 'package:practicum/src/utils/utils.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class Login extends StatelessWidget {
  static final String routeName = 'login';
  final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Text(
                  'Ingresar',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 60.0,
                ),
                _crearIdentificador(bloc),
                SizedBox(height: 30.0),
                _crearPassword(bloc),
                SizedBox(height: 30.0),
                _crearBoton(bloc)
              ],
            ),
          ),
          Text('¿Olvidó su contraseña?'),
          SizedBox(height: 100.0)
        ],
      ),
    );
  }

  Widget _crearPassword(LoginBlock bloc) {
    return StreamBuilder(
        stream: bloc.passwordStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.lock_outline,
                    color: Colors.black87,
                  ),
                  labelText: 'Contraseña',
                  counterText: snapshot.data,
                  errorText: snapshot.error),
              onChanged: bloc.changePassword,
            ),
          );
        });
  }

  Widget _crearIdentificador(LoginBlock bloc) {
    return StreamBuilder(
        stream: bloc.identificadorStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.account_circle,
                    color: Colors.black87,
                  ),
                  hintText: 'Identificador',
                  labelText: 'Identificador',
                  counterText: snapshot.data,
                  errorText: snapshot.error),
              onChanged: bloc.changeIdentificador,
            ),
          );
        });
  }

  Widget _crearBoton(LoginBlock bloc) {
    //formValidStream
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 25.0),
              child: Text('Ingresar'),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 0.0,
            color: Colors.black87,
            textColor: Colors.white,
            onPressed: snapshot.hasData ? () => _login(bloc, context) : null);
      },
    );
  }

  _login(LoginBlock bloc, BuildContext context) async {
    Map info = await usuarioProvider.login(bloc.identificador, bloc.password);

    if (info['ok']) {
      if (info['token'] == 3) {
        Navigator.pushReplacementNamed(context, 'alumnos_principal');
      } else if (info['token'] == 2) {
        Navigator.pushReplacementNamed(context, 'docentes_principal');
      } else if (info['token'] == 1) {
        print(info['token']);
        Navigator.pushReplacementNamed(context, 'home_principal');
      }
    } else {
      mostrarAlerta(context, info['mensaje'], 'Login');
    }
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondo = Container(
      height: size.height * 0.4,
      width: double.infinity,
      child: RotatedBox(
              quarterTurns: 2,
              child: WaveWidget(
                config: CustomConfig(
                    gradients: [
                        [Colors.deepPurple, Colors.deepPurple.shade200],
                        [Colors.indigo.shade200, Colors.purple.shade200],
                    ],
                    durations: [19440, 10800],
                    heightPercentages: [0.20, 0.25],
                    blur: MaskFilter.blur(BlurStyle.solid, 10),
                    gradientBegin: Alignment.bottomLeft,
                    gradientEnd: Alignment.topRight,
                ),
                waveAmplitude: 0,
                size: Size(
                    double.infinity,
                    double.infinity,
                ),
              ),
              /*
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(128, 0, 0, 1.0),
        Color.fromRGBO(128, 0, 0, 1.0)
      ])),
      */
    ));

    return Stack(
      children: <Widget>[
        fondo,
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.account_circle, color: Colors.white, size: 100.0),
              SizedBox(height: 10.0, width: double.infinity),
              Text('Practicum',
                  style: TextStyle(color: Colors.indigo.shade700, fontSize: 35.0,))
            ],
          ),
        )
      ],
    );
  }
}
