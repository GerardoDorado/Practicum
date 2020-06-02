import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:practicum/src/models/docentes_models.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';

class DocentesProvider {
  final _prefs = new PreferenciasUsuario();
  //final String _url = 'http://192.168.1.77';
  //final String _url = 'http://10.0.2.2';
  //final String _url = 'http://176.48.28.146';

  Future<bool> crearDocente(DocenteModel docente) async {
    String url = '${ _prefs.direccionHost }/practicum_php/agregarDocente.php';

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(docenteModelToJson(docente)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();

    print(reply);
    return true;
  }

  Future<List<DocenteModel>> cargarDocentes() async {
    final url = '${ _prefs.direccionHost }/practicum_php/consultaDocente.php';
    final resp = await http.get(url);

    if (resp.statusCode == 200) {
      final items = json.decode(resp.body).cast<Map<String, dynamic>>();
      List<DocenteModel> listaDocentes = items.map<DocenteModel>((json) {
        return DocenteModel.fromJson(json);
      }).toList();

      return listaDocentes;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  Future<List<DocenteModel>> cargarDocenteFiltro(String filtro) async {
    final authData = {'filtro': filtro};

    final resp = await http.post('${ _prefs.direccionHost }/practicum_php/consultaDocenteFiltro.php',
        body: json.encode(authData));

    if (resp.statusCode == 200) {
      final items = json.decode(resp.body).cast<Map<String, dynamic>>();
      List<DocenteModel> docentesAlumnos = items.map<DocenteModel>((json) {
        return DocenteModel.fromJson(json);
      }).toList();

      return docentesAlumnos;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  Future<bool> borrarDocente(String id) async {
    final url = '${ _prefs.direccionHost }/practicum_php/eliminarDocente.php';
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

  Future<bool> editarDocente(DocenteModel docente) async {
    String url = '${ _prefs.direccionHost }/practicum_php/editarDocente.php';

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(docenteModelToJson(docente)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();

    print(reply);
    return true;
  }
}
