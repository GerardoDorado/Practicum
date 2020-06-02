import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:practicum/src/models/user_groups_models.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';

class GruposProvider {
  final _prefs = new PreferenciasUsuario();
  Future<List<GruposModel>> cargarGrupos() async {
    final url =
        '${_prefs.direccionHost}/practicum_php/consultaUserGroups.php';
    final resp = await http.get(url);

    if (resp.statusCode == 200) {
      final items = json.decode(resp.body).cast<Map<String, dynamic>>();
      List<GruposModel> listaGrupos = items.map<GruposModel>((json) {
        return GruposModel.fromJson(json);
      }).toList();

      return listaGrupos;
    } else {
      throw Exception('Failed to load internet');
    }
  }
}