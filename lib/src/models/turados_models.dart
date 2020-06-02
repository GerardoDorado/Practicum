// To parse this JSON data, do
//
//     final principalModels = principalModelsFromJson(jsonString);

// To parse this JSON data, do
//
//     final tutoradosModels = tutoradosModelsFromJson(jsonString);

import 'dart:convert';

TutoradosModels tutoradosModelsFromJson(String str) => TutoradosModels.fromJson(json.decode(str));

String tutoradosModelsToJson(TutoradosModels data) => json.encode(data.toJson());

class TutoradosModels {
    String matricula;
    String nombre;
    String primerAp;
    String segundoAp;
    int semestre;
    String email;
    bool selected;

    TutoradosModels({
        this.matricula="",
        this.nombre="",
        this.primerAp="",
        this.segundoAp="",
        this.semestre=0,
        this.email="",
        this.selected=false,
    });

    factory TutoradosModels.fromJson(Map<String, dynamic> json) => TutoradosModels(
        matricula: json["matricula"],
        nombre: json["nombre"],
        primerAp: json["primerAp"],
        segundoAp: json["segundoAp"],
        semestre: int.parse(json["semestre"]),
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "matricula": matricula,
        "nombre": nombre,
        "primerAp": primerAp,
        "segundoAp": segundoAp,
        "semestre": semestre,
        "email": email,
    };
}

