// To parse this JSON data, do
//
//     final alumnoModel = alumnoModelFromJson(jsonString);

import 'dart:convert';

AlumnoModel alumnoModelFromJson(String str) => AlumnoModel.fromJson(json.decode(str));

String alumnoModelToJson(AlumnoModel data) => json.encode(data.toJson());

class AlumnoModel {
    int matricula;
    String nombre;
    String primerAp;
    String segundoAp;
    //String fechaNacimiento;
    String licenciatura;
    String image;
    int semestre;
    bool estado;
    bool selected;
    String email;
    int edad;

    AlumnoModel({
        this.matricula=0,
        this.nombre = '',
        this.primerAp = '',
        this.segundoAp = '',
        //this.fechaNacimiento = '',
        this.edad=0,
        this.licenciatura = '',
        this.image = '',
        this.semestre = 0,
        this.estado = true,
        this.selected = false,
        this.email = '',
    });

    factory AlumnoModel.fromJson(Map<String, dynamic> json) => new AlumnoModel(
        matricula: int.parse(json["matricula"]),
        nombre: json["nombreA"],
        primerAp: json["primerAp"],
        segundoAp: json["SegundoAp"],
        //fechaNacimiento: json["fechaNacimiento"],
        edad: int.parse(json["edad"]),
        licenciatura: json["nombreL"],
        image: json["image"],
        semestre: int.parse(json["Semestre"]),
        estado: json["estado"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "matricula": matricula,
        "nombre": nombre,
        "primerAp": primerAp,
        "SegundoAp": segundoAp,
        //"fechaNacimiento": fechaNacimiento,
        "edad": edad,
        "Licenciatura": licenciatura,
        "Semestre": semestre,
        "activo": estado,
        "email": email,
    };
}

