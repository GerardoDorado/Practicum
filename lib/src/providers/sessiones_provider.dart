import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practicum/src/models/sessiones_alumnos_models.dart';

import 'package:practicum/src/models/sessiones_models.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';

class SessionesProvider {
  final _prefs = new PreferenciasUsuario();
  Future<List<SessionesModel>> cargarSessiones() async {
    final authData = {'claveD': _prefs.username};
    final resp = await http.post('${ _prefs.direccionHost }/practicum_php/consultaSessiones.php',
        body: json.encode(authData));
        
    if (resp.statusCode == 200) {
      final items = json.decode(resp.body).cast<Map<String, dynamic>>();
      List<SessionesModel> listaSessiones = items.map<SessionesModel>((json) {
        return SessionesModel.fromJson(json);
      }).toList();

      return listaSessiones;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  Future<List<SessionesAlumnosModels>> cargarSessionesAlumnos() async {
    final authData = {'matricula': _prefs.username};
    final resp = await http.post('${ _prefs.direccionHost }/practicum_php/consultaSessionesAlumnos.php',
        body: json.encode(authData));
        
    if (resp.statusCode == 200) {
      final items = json.decode(resp.body).cast<Map<String, dynamic>>();
      List<SessionesAlumnosModels> listaSessiones = items.map<SessionesAlumnosModels>((json) {
        return SessionesAlumnosModels.fromJson(json);
      }).toList();

      return listaSessiones;
    } else {
      throw Exception('Failed to load internet');
    }
  }
}