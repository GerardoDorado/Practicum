import 'dart:convert';

import 'package:practicum/src/models/principal_models.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';
import 'package:http/http.dart' as http;

class PrincipalProvider {
  final _prefs = new PreferenciasUsuario();
  Future<List<PrincipalModels>> cargarPrincipal() async {
    final url =
        '${_prefs.direccionHost}/practicum_php/consultaPrincipal.php';
    final resp = await http.get(url);

    if (resp.statusCode == 200) {
      final items = json.decode(resp.body).cast<Map<String, dynamic>>();
      List<PrincipalModels> listaPrincipal = items.map<PrincipalModels>((json) {
        return PrincipalModels.fromJson(json);
      }).toList();

      return listaPrincipal;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  Future<Map<String, dynamic>> cargarPrincipalMap() async {
    Map<String, dynamic> decodedResp;

    final resp = await http.post('${ _prefs.direccionHost }/practicum_php/consultaPrincipal.php');

    try {
      decodedResp = json.decode(resp.body);
      print(decodedResp);
    } catch (_) {
      decodedResp = {"": ""};
    }

    return decodedResp;
  }
}
