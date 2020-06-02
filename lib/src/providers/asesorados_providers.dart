import 'dart:convert';

import 'package:practicum/src/models/asesorados_models.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';

import 'package:http/http.dart' as http;

class AsesoradosProvider {
  final _prefs = new PreferenciasUsuario();
  Future<List<AsesoradosModel>> cargarAsesorados() async {
    final authData = {'claveD': _prefs.username};
    final resp = await http.post('${ _prefs.direccionHost }/practicum_php/consultaAsesorados.php',
        body: json.encode(authData));

    if (resp.statusCode == 200) {
      final items = json.decode(resp.body).cast<Map<String, dynamic>>();
      List<AsesoradosModel> listaAsesorados = items.map<AsesoradosModel>((json) {
        return AsesoradosModel.fromJson(json);
      }).toList();

      return listaAsesorados;
    } else {
      throw Exception('Failed to load internet');
    }
  }
}