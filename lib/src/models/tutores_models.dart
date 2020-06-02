// To parse this JSON data, do
//
//     final modeloX = modeloXFromJson(jsonString);

import 'dart:convert';

TutoresModel tutoresModelFromJson(String str) => TutoresModel.fromJson(json.decode(str));

String tutoresModelToJson(TutoresModel data) => json.encode(data.toJson());

class TutoresModel {
    String claveD;
    int matricula;
    String alumno;
    String docente;
    String primerAp;
    String segundoAp;
    String gradoAc;

    TutoresModel({
        this.claveD,
        this.matricula,
        this.alumno,
        this.docente,
        this.primerAp,
        this.segundoAp,
        this.gradoAc
    });

    factory TutoresModel.fromJson(Map<String, dynamic> json) => TutoresModel(
        claveD: json["ClaveD"],
        matricula: int.parse(json["Matricula"]),
        alumno: json["Alumno"],
        docente: json["Docente"],
        primerAp: json["primerAp"],
        segundoAp: json["SegundoAp"],
        gradoAc: json["GradoAc"],
    );

    Map<String, dynamic> toJson() => {
        "claveD": claveD,
        "Matricula": matricula,
        "Alumno": alumno,
        "Docente": docente,
    };
}
