// To parse this JSON data, do
//
//     final actividadesModels = actividadesModelsFromJson(jsonString);

import 'dart:convert';

ActividadesModels actividadesModelsFromJson(String str) => ActividadesModels.fromJson(json.decode(str));

String actividadesModelsToJson(ActividadesModels data) => json.encode(data.toJson());

class ActividadesModels {
    String matricula;
    String nombre;
    String primerAp;
    String segundoAp;
    String actividad;
    int estado;
    String fecha;
    int id;

    ActividadesModels({
        this.matricula="",
        this.nombre="",
        this.primerAp="",
        this.segundoAp="",
        this.actividad="",
        this.estado=0,
        this.fecha="",
        this.id=0,
    });

    factory ActividadesModels.fromJson(Map<String, dynamic> json) => ActividadesModels(
        matricula: json["matricula"],
        nombre: json["nombre"],
        primerAp: json["primerAp"],
        segundoAp: json["SegundoAp"],
        actividad: json["actividad"],
        estado: int.parse(json["estado"]),
        fecha: json["fecha"],
        id: int.parse(json["id"]),
    );

    Map<String, dynamic> toJson() => {
        "matricula": matricula,
        "nombre": nombre,
        "primerAp": primerAp,
        "segundoAp": segundoAp,
        "actividad": actividad,
        "estado": estado,
        "fecha": fecha,
        "id": id,
    };
}
