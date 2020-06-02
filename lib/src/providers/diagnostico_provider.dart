import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:practicum/src/models/diagnostico_models.dart';
import 'package:practicum/src/models/diagnosticos_alumnos_models.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';

class DiagnosticoProvider {
  final _prefs = new PreferenciasUsuario();

  Future<bool> crearDiagnostico(DiagnosticoModel diagnostico) async {
    final authData = {'claveD': _prefs.username};

    String url = '${ _prefs.direccionHost }/practicum_php/agregarDocente.php';
    json.encode(authData);
    
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(diagnosticoModelToJson(diagnostico)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();

    print(reply);
    return true;
  }
  
  Future<List<DiagnosticoModel>> cargarDiagnostico() async {
    final authData = {'claveD': _prefs.username};
    final resp = await http.post('${ _prefs.direccionHost }/practicum_php/consultaDiagnostico.php',
        body: json.encode(authData));
        
    if (resp.statusCode == 200) {
      final items = json.decode(resp.body).cast<Map<String, dynamic>>();
      List<DiagnosticoModel> listaDiagnostivo = items.map<DiagnosticoModel>((json) {
        return DiagnosticoModel.fromJson(json);
      }).toList();

      return listaDiagnostivo;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  Future<List<DiagnosticosAlumnosModels>> cargarDiagnosticoAlumnos() async {
    final authData = {'matricula': _prefs.username};
    final resp = await http.post('${ _prefs.direccionHost }/practicum_php/consultaDiagnosticoAlumnos.php',
        body: json.encode(authData));
        
    if (resp.statusCode == 200) {
      final items = json.decode(resp.body).cast<Map<String, dynamic>>();
      List<DiagnosticosAlumnosModels> listaDiagnostivo = items.map<DiagnosticosAlumnosModels>((json) {
        return DiagnosticosAlumnosModels.fromJson(json);
      }).toList();

      return listaDiagnostivo;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  Future<List<DiagnosticoModel>> cargarDiagnosticoFiltro(String filtro) async {
    final authData = {'filtro': filtro};

    final resp = await http.post('${ _prefs.direccionHost }/practicum_php/consultaDiagnosticoFiltro.php',
        body: json.encode(authData));

    if (resp.statusCode == 200) {
      final items = json.decode(resp.body).cast<Map<String, dynamic>>();
      List<DiagnosticoModel> listaDiagnostico = items.map<DiagnosticoModel>((json) {
        return DiagnosticoModel.fromJson(json);
      }).toList();

      return listaDiagnostico;
    } else {
      throw Exception('Failed to load internet');
    }
    
  }
    Future<bool> borrarDiagnostico(String id) async {
    final url = '${ _prefs.direccionHost }/practicum_php/eliminarDiagnostico.php';
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(jsonEncode({"id": id})));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();

    print(reply);
    return true;
  }
    

  Future<bool> editarDiagnostico(DiagnosticoModel diagnostico) async {
    String url = '${ _prefs.direccionHost }/practicum_php/editarDiagnostico.php';

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(diagnosticoModelToJson(diagnostico)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();

    print(reply);
    return true;
  }
}