import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:practicum/src/models/turados_models.dart';

import 'package:practicum/src/models/tutores_models.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';

class TutoresProvider {
  final _prefs = new PreferenciasUsuario();
  Future<List<TutoresModel>> cargarTutores() async {
    final url =
        '${_prefs.direccionHost}/practicum_php/consultaTutores.php';
    final resp = await http.get(url);

    if (resp.statusCode == 200) {
      final items = json.decode(resp.body).cast<Map<String, dynamic>>();
      List<TutoresModel> listaTutores = items.map<TutoresModel>((json) {
        return TutoresModel.fromJson(json);
      }).toList();

      return listaTutores;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  Future<List<TutoradosModels>> cargarTutorados(String filtro) async {
    final authData = {'claveD': filtro};

    final resp = await http.post('${ _prefs.direccionHost }/practicum_php/consultaTutorados.php',
        body: json.encode(authData));

    if (resp.statusCode == 200) {
      final items = json.decode(resp.body).cast<Map<String, dynamic>>();
      List<TutoradosModels> listaTutorados = items.map<TutoradosModels>((json) {
        return TutoradosModels.fromJson(json);
      }).toList();

      return listaTutorados;
    } else {
      throw Exception('Failed to load internet');
    }
  }
}
