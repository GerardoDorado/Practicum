// To parse this JSON data, do
//
//     final modeloX = modeloXFromJson(jsonString);

import 'dart:convert';

GruposModel gruposModelFromJson(String str) => GruposModel.fromJson(json.decode(str));

String gruposModelToJson(GruposModel data) => json.encode(data.toJson());

class GruposModel {
    int id;
    String groupName;
    int groupLevel;
    //int groupStatus;
    bool estado;

    GruposModel({
        this.id = 0,
        this.groupName = '',
        this.groupLevel = 0,
        this.estado = true,
    });

    factory GruposModel.fromJson(Map<String, dynamic> json) => GruposModel(
        id: int.parse(json["id"]),
        groupName: json["group_name"],
        groupLevel: int.parse(json["group_level"]),
        estado: json["estado"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "group_name": groupName,
        "group_level": groupLevel,
        "estado": estado,
    };
}
