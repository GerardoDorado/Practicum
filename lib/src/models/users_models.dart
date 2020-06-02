// To parse this JSON data, do
//
//     final usuariosModel = usuariosModelFromJson(jsonString);

import 'dart:convert';

UsuariosModel usuariosModelFromJson(String str) => UsuariosModel.fromJson(json.decode(str));

String usuariosModelToJson(UsuariosModel data) => json.encode(data.toJson());

class UsuariosModel {
    int id;
    String name;
    String username;
    String lastLogin;
    String groupName;
    int userLevel;
    bool estado;
    String imagen;

    UsuariosModel({
        this.id=0,
        this.name='',
        this.username='',
        this.lastLogin='',
        this.groupName='',
        this.userLevel=0,
        this.estado=true,
        this.imagen = '',
    });

    factory UsuariosModel.fromJson(Map<String, dynamic> json) => UsuariosModel(
        id: int.parse(json["id"]),
        name: json["name"],
        username: json["username"],
        lastLogin: json["last_login"],
        groupName: json["group_name"],
        userLevel: int.parse(json["user_level"]),
        estado: json["estado"],
        imagen: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "last_login": lastLogin,
        "group_name": groupName,
        "user_level": userLevel,
        "estado": estado,
    };
}
