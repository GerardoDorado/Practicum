import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:practicum/src/models/plan_estudios.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';

class PlanEstudiosProvider {
  final _prefs = new PreferenciasUsuario();
  Future<List<PlanEstudiosModel>> cargarPlanEstudios() async {
    final url =
        '${_prefs.direccionHost}/practicum_php/consultaPlanEstudios.php';
    final resp = await http.get(url);

    if (resp.statusCode == 200) {
      final items = json.decode(resp.body).cast<Map<String, dynamic>>();
      List<PlanEstudiosModel> listaPlanEstudios = items.map<PlanEstudiosModel>((json) {
        return PlanEstudiosModel.fromJson(json);
      }).toList();

      return listaPlanEstudios;
    } else {
      throw Exception('Failed to load internet');
    }
  }
}