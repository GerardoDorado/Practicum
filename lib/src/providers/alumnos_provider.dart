import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:practicum/src/models/alumnos_models.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';

class AlumnosProvider {
  final _prefs = new PreferenciasUsuario();
  //final String _url = 'http://192.168.1.77';
  //final String _url = 'http://10.0.2.2';

  /*Future<bool> crearAlumno( AlumnoModel alumno ) async {
    String url = '$_url/practicum_php/agregarAlumno.php';
    var resp = await http.post(Uri.encodeFull(url), headers: { "Content-Type": "application/x-www-form-urlencoded" , "Content-type": "application/json" }, 
                  body: alumnoModelToJson(alumno), encoding: Encoding.getByName("utf-8" ));
    //print(JsonEncoder().convert(alumnoModelToJson(alumno)) );
    print(alumnoModelToJson(alumno) );

    if (resp.statusCode < 200 || resp.statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }else {
      var decodedData = json.decode(resp.body);
      print( decodedData );
    }

    /*var decodedData = json.decode(resp.body);
    print( decodedData );
    */
    return true;  
  }*/

  Future<bool> crearAlumno(AlumnoModel alumno) async {
    String url = '${ _prefs.direccionHost }/practicum_php/agregarAlumno.php';

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(alumnoModelToJson(alumno)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();

    print(reply);
    return true;
  }

  Future<List<AlumnoModel>> cargarALumnos() async {
    final url = '${ _prefs.direccionHost }/practicum_php/consultaAlumnos.php';
    final resp = await http.get(
      Uri.encodeFull(url),
      headers: {"Accept": "application/json"},
    );

    if (resp.statusCode == 200) {
      final items = json.decode(resp.body).cast<Map<String, dynamic>>();
      List<AlumnoModel> listaAlumnos = items.map<AlumnoModel>((json) {
        return AlumnoModel.fromJson(json);
      }).toList();

      return listaAlumnos;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  Future<List<AlumnoModel>> cargarALumnosFiltro(String filtro) async {
    final authData = {'filtro': filtro};

    final resp = await http.post('${ _prefs.direccionHost }/practicum_php/consultaAlumnosFiltro.php',
        body: json.encode(authData));

    if (resp.statusCode == 200) {
      final items = json.decode(resp.body).cast<Map<String, dynamic>>();
      List<AlumnoModel> listaAlumnos = items.map<AlumnoModel>((json) {
        return AlumnoModel.fromJson(json);
      }).toList();

      return listaAlumnos;
    } else {
      throw Exception('Failed to load internet');
    }
  }


  Future<bool> borrarAlumno(String id) async {
    final url = '${ _prefs.direccionHost }/practicum_php/eliminarAlumno.php';
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

  Future<bool> editarAlumno(AlumnoModel alumno) async {
    String url = '${ _prefs.direccionHost }/practicum_php/editarAlumno.php';

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(alumnoModelToJson(alumno)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();

    print(reply);
    return true;
  }
}
