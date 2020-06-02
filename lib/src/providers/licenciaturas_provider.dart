import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:practicum/src/models/licenciaturas_models.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';

class LicenciaturasProvider {
  final _prefs = new PreferenciasUsuario();
  //final String _url = 'http://192.168.1.77';
  //final String _url = 'http://10.0.2.2';
  
  Future<bool> crearLicenciatura(LicenciaturaModel licenciatura) async {
    String url = '${ _prefs.direccionHost }/practicum_php/agregarLicenciatura.php';

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(licenciaturaModelToJson(licenciatura)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();

    print(reply);
    return true;
  }

  Future<List<LicenciaturaModel>> cargarLicenciaturas() async {
    final url = '${ _prefs.direccionHost }/practicum_php/consultaLicenciatura.php';
    final resp = await http.get(url);

    if (resp.statusCode == 200) {
      final items = json.decode(resp.body).cast<Map<String, dynamic>>();
      List<LicenciaturaModel> listaLicenciatura =
          items.map<LicenciaturaModel>((json) {
        return LicenciaturaModel.fromJson(json);
      }).toList();

      return listaLicenciatura;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  Future<bool> borrarLicenciatura(String id) async {
    final url = '${ _prefs.direccionHost }/practicum_php/eliminarLicenciatura.php';
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

  Future<bool> editarLicenciatura(LicenciaturaModel licenciatura) async {
    String url = '${ _prefs.direccionHost }/practicum_php/editarLicenciatura.php';

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(licenciaturaModelToJson(licenciatura)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();

    print(reply);
    return true;
  }
}
