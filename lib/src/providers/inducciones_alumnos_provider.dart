import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:practicum/src/models/inducciones_alumnos_models.dart';

import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';

class InduccionesAlumnosProvider {
  final _prefs = new PreferenciasUsuario();
  
  Future<List<InduccionesAlumnosModels>> cargarDatosInduccionesAlumnos() async {
    final authData = {'matricula': _prefs.username};

    final resp = await http.post('${ _prefs.direccionHost }/practicum_php/consultaInduccionAlumnos.php',
        body: json.encode(authData));

    if (resp.statusCode == 200) {
      final items = json.decode(resp.body).cast<Map<String, dynamic>>();
      List<InduccionesAlumnosModels> listaInducciones = items.map<InduccionesAlumnosModels>((json) {
        return InduccionesAlumnosModels.fromJson(json);
      }).toList();

      return listaInducciones;
    } else {
      throw Exception('Failed to load internet');
    }
  }
}