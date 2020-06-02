import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:practicum/src/models/evaluacion_clase_models.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';

class EvaluacionClaseProvider {
  final _prefs = new PreferenciasUsuario();
  
  Future<List<EvaluacionClaseModel>> cargarEvaluacionClase() async {
    final authData = {'claveD': _prefs.username};

    final resp = await http.post('${ _prefs.direccionHost }/practicum_php/consultaEvaluacionClase.php',
        body: json.encode(authData));

    if (resp.statusCode == 200) {
      final items = json.decode(resp.body).cast<Map<String, dynamic>>();
      List<EvaluacionClaseModel> listaEvaluacionClase = items.map<EvaluacionClaseModel>((json) {
        return EvaluacionClaseModel.fromJson(json);
      }).toList();

      return listaEvaluacionClase;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  Future<List<EvaluacionClaseModel>> cargarEvaluacionClaseAlumno() async {
    final authData = {'matricula': _prefs.username};

    final resp = await http.post('${ _prefs.direccionHost }/practicum_php/consultaEvaluacionClaseAlumno.php',
        body: json.encode(authData));

    if (resp.statusCode == 200) {
      final items = json.decode(resp.body).cast<Map<String, dynamic>>();
      List<EvaluacionClaseModel> listaEvaluacionClase = items.map<EvaluacionClaseModel>((json) {
        return EvaluacionClaseModel.fromJson(json);
      }).toList();

      return listaEvaluacionClase;
    } else {
      throw Exception('Failed to load internet');
    }
  }
}