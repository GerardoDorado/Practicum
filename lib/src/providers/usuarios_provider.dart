import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';

class UsuarioProvider {
  final _prefs = new PreferenciasUsuario();
  
  Future<Map<String, dynamic>> login(String email, String password) async {
    Map<String, dynamic> decodedResp;
    final authData = {'email': email, 'password': password};

    final resp = await http.post('${ _prefs.direccionHost }/practicum_php/login.php',
        body: json.encode(authData));

    try {
      decodedResp = json.decode(resp.body);
      print(decodedResp);
    } catch (_) {
      decodedResp = {"": ""};
    }

    if (decodedResp.containsKey('id')) {
      _prefs.nombreUsuario="${ decodedResp['name'] } ${ decodedResp['primerAp'] } ${ decodedResp['SegundoAp'] } ";
      _prefs.username = decodedResp['username'];
      _prefs.image = decodedResp['image'];

      return {'ok': true, 'token': decodedResp['user_level']};
    } else {
      return {'ok': false, 'mensaje': '¡Usuario no encontrado!'};
    }
  }
}
