// To parse this JSON data, do
//
//     final evaluacionClaseModel = evaluacionClaseModelFromJson(jsonString);

import 'dart:convert';

EvaluacionClaseModel evaluacionClaseModelFromJson(String str) => EvaluacionClaseModel.fromJson(json.decode(str));

String evaluacionClaseModelToJson(EvaluacionClaseModel data) => json.encode(data.toJson());

class EvaluacionClaseModel {
    int id;
    int matricula;
    String nombre;
    String fortaleza;
    String fecha;
    String observacion;
    String evaluacion;
    String aspectos;
    String evidencia;
    String preguntas;
    String reflexion;
    String atencion;
    String formas;
    String primerAp;
    String segundoAp;

    EvaluacionClaseModel({
        this.id,
        this.matricula,
        this.nombre,
        this.fortaleza,
        this.fecha,
        this.observacion,
        this.evaluacion,
        this.aspectos,
        this.evidencia,
        this.preguntas,
        this.reflexion,
        this.atencion,
        this.formas,
        this.primerAp, 
        this.segundoAp
    });

    factory EvaluacionClaseModel.fromJson(Map<String, dynamic> json) => EvaluacionClaseModel(
        id: int.parse(json["id"]),
        matricula: int.parse(json["matricula"]),
        nombre: json["nombre"],
        fortaleza: json["fortaleza"],
        fecha: json["fecha"],
        observacion: json["observacion"],
        evaluacion: json["evaluacion"],
        aspectos: json["aspectos"],
        evidencia: json["evidencia"],
        preguntas: json["preguntas"],
        reflexion: json["reflexion"],
        atencion: json["atencion"],
        formas: json["formas"],
        primerAp: json["primerAp"],
        segundoAp: json["SegundoAp"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "matricula": matricula,
        "nombre": nombre,
        "fortaleza": fortaleza,
        "fecha": fecha,
        "observacion": observacion,
        "evaluacion": evaluacion,
        "aspectos": aspectos,
        "evidencia": evidencia,
        "preguntas": preguntas,
        "reflexion": reflexion,
        "atencion": atencion,
        "formas": formas,
    };
}
