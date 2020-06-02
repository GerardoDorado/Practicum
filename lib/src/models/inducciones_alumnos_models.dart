// To parse this JSON data, do
//
//     final induccionesAlumnosModels = induccionesAlumnosModelsFromJson(jsonString);

import 'dart:convert';

InduccionesAlumnosModels induccionesAlumnosModelsFromJson(String str) => InduccionesAlumnosModels.fromJson(json.decode(str));

String induccionesAlumnosModelsToJson(InduccionesAlumnosModels data) => json.encode(data.toJson());

class InduccionesAlumnosModels {
    String nombre;
    String tematica;
    String evaluacion;
    String modalidad;
    int id;

    InduccionesAlumnosModels({
        this.nombre="",
        this.tematica="",
        this.evaluacion="",
        this.modalidad="",
        this.id=0,
    });

    factory InduccionesAlumnosModels.fromJson(Map<String, dynamic> json) => InduccionesAlumnosModels(
        nombre: json["nombre"],
        tematica: json["tematica"],
        evaluacion: json["evaluacion"],
        modalidad: json["modalidad"],
        id: int.parse(json["id"]),
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "tematica": tematica,
        "evaluacion": evaluacion,
        "modalidad": modalidad,
        "id": id,
    };
}
