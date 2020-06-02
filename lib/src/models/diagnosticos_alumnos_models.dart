// To parse this JSON data, do
//
//     final diagnosticosAlumnosModels = diagnosticosAlumnosModelsFromJson(jsonString);

import 'dart:convert';

DiagnosticosAlumnosModels diagnosticosAlumnosModelsFromJson(String str) => DiagnosticosAlumnosModels.fromJson(json.decode(str));

String diagnosticosAlumnosModelsToJson(DiagnosticosAlumnosModels data) => json.encode(data.toJson());

class DiagnosticosAlumnosModels {
    String matricula;
    String nombre;
    String primerAp;
    String segundoAp;
    String fortaleza;
    String debilidad;
    String id;
    String aspecto;
    String estrategia;
    int estado;

    DiagnosticosAlumnosModels({
        this.matricula="",
        this.nombre="",
        this.primerAp="",
        this.segundoAp="",
        this.fortaleza="",
        this.debilidad="",
        this.id="",
        this.aspecto="",
        this.estrategia="",
        this.estado=0,
    });

    factory DiagnosticosAlumnosModels.fromJson(Map<String, dynamic> json) => DiagnosticosAlumnosModels(
        matricula: json["matricula"],
        nombre: json["nombre"],
        primerAp: json["primerAp"],
        segundoAp: json["SegundoAp"],
        fortaleza: json["fortaleza"],
        debilidad: json["debilidad"],
        id: json["id"],
        aspecto: json["aspecto"],
        estrategia: json["estrategia"],
        estado: int.parse(json["estado"]),
    );

    Map<String, dynamic> toJson() => {
        "matricula": matricula,
        "nombre": nombre,
        "primerAp": primerAp,
        "segundoAp": segundoAp,
        "fortaleza": fortaleza,
        "debilidad": debilidad,
        "id": id,
        "aspecto": aspecto,
        "estrategia": estrategia,
        "estado": estado,
    };
}
