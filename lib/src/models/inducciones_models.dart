// To parse this JSON data, do
//
//     final induccionesModel = induccionesModelFromJson(jsonString);

import 'dart:convert';

InduccionesModel induccionesModelFromJson(String str) => InduccionesModel.fromJson(json.decode(str));

String induccionesModelToJson(InduccionesModel data) => json.encode(data.toJson());

class InduccionesModel {
    int id = 0;
    String proyecto = "";
    int matricula = 0;
    String estado="";
    String evaluacion="";
    String nombre = "";
    String primerAp;
    String segundoAp;

    bool activo = true;

    InduccionesModel({
        this.id,
        this.proyecto,
        this.matricula,
        this.estado,
        this.evaluacion,
        this.nombre,
        this.activo,
        this.primerAp, 
        this.segundoAp
    });

    factory InduccionesModel.fromJson(Map<String, dynamic> json) => InduccionesModel(
        id: int.parse(json["id"]),
        proyecto: json["proyecto"],
        matricula: int.parse(json["matricula"]),
        estado: json["estado"],
        evaluacion: json["evaluacion"],
        nombre: json["nombre"],
        activo: json["activo"],
        primerAp: json["primerAp"],
        segundoAp: json["SegundoAp"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "proyecto": proyecto,
        "matricula": matricula,
        "estado": estado,
        "evaluacion": evaluacion,
        "nombre": nombre,
        "activo": activo,
    };
}
