import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:practicum/src/models/users_models.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';

class UsersProvider {
  final _prefs = new PreferenciasUsuario();
  Future<List<UsuariosModel>> cargarUsuarios() async {
    final url =
        '${_prefs.direccionHost}/practicum_php/consultaUsuarios.php';
    final resp = await http.get(url);

    if (resp.statusCode == 200) {
      final items = json.decode(resp.body).cast<Map<String, dynamic>>();
      List<UsuariosModel> listaUsuarios = items.map<UsuariosModel>((json) {
        return UsuariosModel.fromJson(json);
      }).toList();

      return listaUsuarios;
    } else {
      throw Exception('Failed to load internet');
    }
  }
}