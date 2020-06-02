// To parse this JSON data, do
//
//     final sessionesAlumnosModels = sessionesAlumnosModelsFromJson(jsonString);

import 'dart:convert';

SessionesAlumnosModels sessionesAlumnosModelsFromJson(String str) => SessionesAlumnosModels.fromJson(json.decode(str));

String sessionesAlumnosModelsToJson(SessionesAlumnosModels data) => json.encode(data.toJson());

class SessionesAlumnosModels {
    String matricula;
    String nombre;
    String primerAp;
    String segundoAp;
    String proposito;
    String fecha;
    String id;
    String ide;
    String acuerdos;

    SessionesAlumnosModels({
        this.matricula="",
        this.nombre="",
        this.primerAp="",
        this.segundoAp="",
        this.proposito="",
        this.fecha="",
        this.id="",
        this.ide="",
        this.acuerdos="",
    });

    factory SessionesAlumnosModels.fromJson(Map<String, dynamic> json) => SessionesAlumnosModels(
        matricula: json["matricula"],
        nombre: json["nombre"],
        primerAp: json["primerAp"],
        segundoAp: json["SegundoAp"],
        proposito: json["proposito"],
        fecha: json["fecha"],
        id: json["id"],
        ide: json["IDE"],
        acuerdos: json["acuerdos"],
    );

    Map<String, dynamic> toJson() => {
        "matricula": matricula,
        "nombre": nombre,
        "primerAp": primerAp,
        "segundoAp": segundoAp,
        "proposito": proposito,
        "fecha": fecha,
        "id": id,
        "IDE": ide,
        "acuerdos": acuerdos,
    };
}
