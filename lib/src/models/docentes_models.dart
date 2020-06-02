// To parse this JSON data, do
//
//     final docenteModel = docenteModelFromJson(jsonString);

import 'dart:convert';

DocenteModel docenteModelFromJson(String str) => DocenteModel.fromJson(json.decode(str));

String docenteModelToJson(DocenteModel data) => json.encode(data.toJson());

class DocenteModel {
    String claveD;
    String nombre;
    String primerAp;
    String segundoAp;
    int edad;
    String email;
    String image;
    bool activo;
    String gradoAc;

    DocenteModel({
        this.claveD="",
        this.nombre="",
        this.primerAp="",
        this.segundoAp="",
        this.edad=0,
        this.email="",
        this.activo=true,
        this.gradoAc="",
        this.image="",
    });

    factory DocenteModel.fromJson(Map<String, dynamic> json) => DocenteModel(
        claveD: json["claveD"],
        nombre: json["nombre"],
        primerAp: json["primerAp"],
        segundoAp: json["SegundoAp"],
        edad: int.parse(json["edad"]),
        email: json["email"],
        activo: json["estado"],
        gradoAc: json["GradoAc"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "claveD": claveD,
        "nombre": nombre,
        "primerAp": primerAp,
        "segundoAp": segundoAp,
        "edad": edad,
        "email": email,
        "activo": activo,
        "gradoAc": gradoAc,
    };
}
