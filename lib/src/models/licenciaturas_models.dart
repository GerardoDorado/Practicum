// To parse this JSON data, do
//
//     final licenciaturaModel = licenciaturaModelFromJson(jsonString);

import 'dart:convert';

LicenciaturaModel licenciaturaModelFromJson(String str) => LicenciaturaModel.fromJson(json.decode(str));

String licenciaturaModelToJson(LicenciaturaModel data) => json.encode(data.toJson());

class LicenciaturaModel {
    int claveLic;
    String nombre;
    bool activo;

    LicenciaturaModel({
        this.claveLic=0,
        this.nombre="",
        this.activo=true,
    });

    factory LicenciaturaModel.fromJson(Map<String, dynamic> json) => LicenciaturaModel(
        claveLic: int.parse(json['claveLic']),
        nombre: json["nombre"],
        activo: json["estado"],
    );

    Map<String, dynamic> toJson() => {
        "claveLic": claveLic,
        "nombre": nombre,
        "activo": activo,
    };
  }
