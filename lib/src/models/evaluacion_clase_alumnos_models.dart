// To parse this JSON data, do
//
//     final evaluacionClaseAlumnosModels = evaluacionClaseAlumnosModelsFromJson(jsonString);

import 'dart:convert';

EvaluacionClaseAlumnosModels evaluacionClaseAlumnosModelsFromJson(String str) => EvaluacionClaseAlumnosModels.fromJson(json.decode(str));

String evaluacionClaseAlumnosModelsToJson(EvaluacionClaseAlumnosModels data) => json.encode(data.toJson());

class EvaluacionClaseAlumnosModels {
    String matricula;
    String nombre;
    String primerAp;
    String segundoAp;
    String observacion;
    String evaluacion;
    String evidencia;
    String aspectos;
    String fortaleza;
    String fecha;
    String formas;
    String preguntas;
    String reflexion;
    String atencion;
    String id;

    EvaluacionClaseAlumnosModels({
        this.matricula="",
        this.nombre="",
        this.primerAp="",
        this.segundoAp="",
        this.observacion="",
        this.evaluacion="",
        this.evidencia="",
        this.aspectos="",
        this.fortaleza="",
        this.fecha="",
        this.formas="",
        this.preguntas="",
        this.reflexion="",
        this.atencion="",
        this.id="",
    });

    factory EvaluacionClaseAlumnosModels.fromJson(Map<String, dynamic> json) => EvaluacionClaseAlumnosModels(
        matricula: json["matricula"],
        nombre: json["nombre"],
        primerAp: json["primerAp"],
        segundoAp: json["segundoAp"],
        observacion: json["observacion"],
        evaluacion: json["evaluacion"],
        evidencia: json["evidencia"],
        aspectos: json["aspectos"],
        fortaleza: json["fortaleza"],
        fecha: json["fecha"],
        formas: json["formas"],
        preguntas: json["preguntas"],
        reflexion: json["reflexion"],
        atencion: json["atencion"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "matricula": matricula,
        "nombre": nombre,
        "primerAp": primerAp,
        "segundoAp": segundoAp,
        "observacion": observacion,
        "evaluacion": evaluacion,
        "evidencia": evidencia,
        "aspectos": aspectos,
        "fortaleza": fortaleza,
        "fecha": fecha,
        "formas": formas,
        "preguntas": preguntas,
        "reflexion": reflexion,
        "atencion": atencion,
        "id": id,
    };
}
