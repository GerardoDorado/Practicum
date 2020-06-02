import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
  
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del direccionHost
  get direccionHost {
    //return _prefs.getString('direccionHost') ?? 'http://176.48.16.17/controlador';
    //return _prefs.getString('direccionHost') ?? 'http://normal-practicum.epizy.com/controlador';
    //return _prefs.getString('direccionHost') ?? 'http://10.0.2.2';
    //return _prefs.getString('direccionHost') ?? 'http://normal-practicum.byethost13.com/libs';
     return _prefs.getString('direccionHost') ?? 'http://192.168.1.74/Practicum-master/libs';
    //return _prefs.getString('direccionHost') ?? 'http://10.0.2.2/Practicum-master/libs';
  }

  set direccionHost(String value) {
    _prefs.setString('direccionHost', value);
  }

  // GET y SET del nombreUsuario
  get nombreUsuario {
    return _prefs.getString('nombreUsuario') ?? '';
  }

  set nombreUsuario(String value) {
    _prefs.setString('nombreUsuario', value);
  }

  // GET y SET del username
  get username {
    return _prefs.getString('username') ?? '';
  }

  set username(String value) {
    _prefs.setString('username', value);
  }

  get image {
    return _prefs.getString('image') ?? '';
  }

  set image(String value) {
    _prefs.setString('image', value);
  }
}
