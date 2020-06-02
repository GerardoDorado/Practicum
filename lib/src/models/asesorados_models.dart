// To parse this JSON data, do
//
//     final asesoradosModel = asesoradosModelFromJson(jsonString);

import 'dart:convert';

AsesoradosModel asesoradosModelFromJson(String str) => AsesoradosModel.fromJson(json.decode(str));

String asesoradosModelToJson(AsesoradosModel data) => json.encode(data.toJson());

class AsesoradosModel {
    int matricula;
    String nombre;
    String primerAp;
    String segundoAp;
    String edad;
    String email;
    String licenciatura;
    String image;
    bool estado;
    int semestre;

    AsesoradosModel({
        this.matricula,
        this.nombre,
        this.primerAp,
        this.segundoAp,
        this.edad,
        this.email,
        this.licenciatura,
        this.estado,
        this.semestre,
        this.image = '',
    });

    factory AsesoradosModel.fromJson(Map<String, dynamic> json) => AsesoradosModel(
        matricula: int.parse(json["matricula"]),
        nombre: json["nombre"],
        primerAp: json["primerAp"],
        segundoAp: json["SegundoAp"],
        edad: json["edad"],
        email: json["email"],
        licenciatura: json["Licenciatura"],
        estado: json["estado"],
        semestre: int.parse(json["Semestre"]),
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "matricula": matricula,
        "nombre": nombre,
        "primerAp": primerAp,
        "SegundoAp": segundoAp,
        "edad": edad,
        "email": email,
        "Licenciatura": licenciatura,
        "estado": estado,
        "Semestre": semestre,
    };
}
