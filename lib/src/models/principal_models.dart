// To parse this JSON data, do
//
//     final principalModels = principalModelsFromJson(jsonString);

import 'dart:convert';

PrincipalModels principalModelsFromJson(String str) => PrincipalModels.fromJson(json.decode(str));

String principalModelsToJson(PrincipalModels data) => json.encode(data.toJson());

class PrincipalModels {
    int alumno;
    int maestro;
    int tutores;
    int users;
    int planEstudios;
    int licenciatura;

    PrincipalModels({
        this.alumno,
        this.maestro,
        this.tutores,
        this.users,
        this.planEstudios,
        this.licenciatura,
    });

    factory PrincipalModels.fromJson(Map<String, dynamic> json) => PrincipalModels(
        alumno: int.parse(json["alumno"]),
        maestro: int.parse(json["maestro"]),
        tutores: int.parse(json["tutores"]),
        users: int.parse(json["users"]),
        planEstudios: int.parse(json["planEstudios"]),
        licenciatura: int.parse(json["licenciatura"]),
    );

    Map<String, dynamic> toJson() => {
        "alumno": alumno,
        "maestro": maestro,
        "tutores": tutores,
        "users": users,
        "planEstudios": planEstudios,
        "licenciatura": licenciatura,
    };
}
