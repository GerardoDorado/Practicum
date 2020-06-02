// To parse this JSON data, do
//
//     final diagnosticoModel = diagnosticoModelFromJson(jsonString);

import 'dart:convert';

DiagnosticoModel diagnosticoModelFromJson(String str) => DiagnosticoModel.fromJson(json.decode(str));

String diagnosticoModelToJson(DiagnosticoModel data) => json.encode(data.toJson());

class DiagnosticoModel {
    int id;
    int matricula;
    String nombre;
    String fortaleza;
    String debilidad;
    String aspecto;
    String estrategia;
    String primerAp;
    String segundoAp;
    bool estadoFinal;

    DiagnosticoModel({
        this.id=0,
        this.matricula=0,
        this.nombre='',
        this.fortaleza='',
        this.debilidad='',
        this.aspecto='',
        this.estrategia='',
        this.estadoFinal=true,
        this.primerAp='',
        this.segundoAp=''
    });

    factory DiagnosticoModel.fromJson(Map<String, dynamic> json) => DiagnosticoModel(
        id: int.parse(json["id"]),
        matricula: int.parse(json["matricula"]),
        nombre: json["nombre"],
        fortaleza: json["fortaleza"],
        debilidad: json["debilidad"],
        aspecto: json["aspecto"],
        estrategia: json["estrategia"],
        estadoFinal: json["estadoFinal"],
        primerAp: json["primerAp"],
        segundoAp: json["SegundoAp"]
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
