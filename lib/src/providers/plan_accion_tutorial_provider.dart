import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:practicum/src/models/actividades_models.dart';

import 'package:practicum/src/models/plan_accion_tutorial_models.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';

class PlanAccionTutorialProvider {
  final _prefs = new PreferenciasUsuario();
  Future<List<PlanAccionTutorialModel>> cargarPlanAccionTutorial() async {
    final authData = {'claveD': _prefs.username};
    final resp = await http.post('${ _prefs.direccionHost }/practicum_php/consultaPlanAcTutorial.php',
        body: json.encode(authData));

    if (resp.statusCode == 200) {
      final items = json.decode(resp.body).cast<Map<String, dynamic>>();
      List<PlanAccionTutorialModel> listaPlanAccionTutorial = items.map<PlanAccionTutorialModel>((json) {
        return PlanAccionTutorialModel.fromJson(json);
      }).toList();

      return listaPlanAccionTutorial;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  Future<List<ActividadesModels>> cargarPlanAccionTutorialAlumno() async {
    final authData = {'matricula': _prefs.username};
    final resp = await http.post('${ _prefs.direccionHost }/practicum_php/consultaActividad.php',
        body: json.encode(authData));

    if (resp.statusCode == 200) {
      final items = json.decode(resp.body).cast<Map<String, dynamic>>();
      List<ActividadesModels> listaActividades = items.map<ActividadesModels>((json) {
        return ActividadesModels.fromJson(json);
      }).toList();

      return listaActividades;
    } else {
      throw Exception('Failed to load internet');
    }
  }
}