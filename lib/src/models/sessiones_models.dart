// To parse this JSON data, do
//
//     final sessionesModel = sessionesModelFromJson(jsonString);

import 'dart:convert';

SessionesModel sessionesModelFromJson(String str) => SessionesModel.fromJson(json.decode(str));

String sessionesModelToJson(SessionesModel data) => json.encode(data.toJson());

class SessionesModel {
    String id;
    int matricula;
    String nombre;
    String proposito;
    String primerAp;
    String segundoAp;
    int ide;
    String acuerdos;

    SessionesModel({
        this.id="",
        this.matricula,
        this.nombre="",
        this.proposito="",
        this.ide,
        this.acuerdos="",
        this.primerAp="",
        this.segundoAp=""
    });

    factory SessionesModel.fromJson(Map<String, dynamic> json) => SessionesModel(
        id: json["id"],
        matricula: int.parse(json["matricula"]),
        nombre: json["nombre"],
        proposito: json["proposito"],
        ide: int.parse(json["IDE"]),
        acuerdos: json["acuerdos"],
        segundoAp: json["SegundoAp"],
        primerAp: json["primerAp"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "matricula": matricula,
        "nombre": nombre,
        "proposito": proposito,
        "IDE": ide,
        "acuerdos": acuerdos,
    };
}
