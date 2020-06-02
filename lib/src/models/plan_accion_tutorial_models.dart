// To parse this JSON data, do
//
//     final planAccionTutorialModel = planAccionTutorialModelFromJson(jsonString);

import 'dart:convert';

PlanAccionTutorialModel planAccionTutorialModelFromJson(String str) => PlanAccionTutorialModel.fromJson(json.decode(str));

String planAccionTutorialModelToJson(PlanAccionTutorialModel data) => json.encode(data.toJson());

class PlanAccionTutorialModel {
    int id;
    int matricula;
    String nombre;
    String primerAp;
    String segundoAp;
    String image;
    String fortaleza;
    String debilidad;
    String aspecto;
    String estrategia;
    bool estadoFinal;

    PlanAccionTutorialModel({
        this.id,
        this.matricula,
        this.nombre,
        this.primerAp,
        this.segundoAp,
        this.image,
        this.fortaleza,
        this.debilidad,
        this.aspecto,
        this.estrategia,
        this.estadoFinal,
    });

    factory PlanAccionTutorialModel.fromJson(Map<String, dynamic> json) => PlanAccionTutorialModel(
        id: int.parse(json["id"]),
        matricula: int.parse(json["matricula"]),
        nombre: json["nombre"],
        primerAp: json["primerAp"],
        segundoAp: json["SegundoAp"],
        image: json["image"],
        fortaleza: json["fortaleza"],
        debilidad: json["debilidad"],
        aspecto: json["aspecto"],
        estrategia: json["estrategia"],
        estadoFinal: json["estadoFinal"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "matricula": matricula,
        "nombre": nombre,
        "fortaleza": fortaleza,
        "debilidad": debilidad,
        "aspecto": aspecto,
        "estrategia": estrategia,
        "estadoFinal": estadoFinal,
    };
}
