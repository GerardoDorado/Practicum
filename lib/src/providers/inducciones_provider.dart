import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:practicum/src/models/inducciones_models.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';

class InduccionesProvider {
  final _prefs = new PreferenciasUsuario();
  
  Future<List<InduccionesModel>> cargarDatosInducciones() async {
    final authData = {'claveD': _prefs.username};

    final resp = await http.post('${ _prefs.direccionHost }/practicum_php/consultaInduccion.php',
        body: json.encode(authData));

    if (resp.statusCode == 200) {
      final items = json.decode(resp.body).cast<Map<String, dynamic>>();
      List<InduccionesModel> listaInducciones = items.map<InduccionesModel>((json) {
        return InduccionesModel.fromJson(json);
      }).toList();

      return listaInducciones;
    } else {
      throw Exception('Failed to load internet');
    }
  }
}