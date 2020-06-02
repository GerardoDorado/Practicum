// To parse this JSON data, do
//
//     final modeloX = modeloXFromJson(jsonString);

import 'dart:convert';

PlanEstudiosModel planEstudiosModelFromJson(String str) => PlanEstudiosModel.fromJson(json.decode(str));

String planEstudiosModelToJson(PlanEstudiosModel data) => json.encode(data.toJson());

class PlanEstudiosModel {
    String idPlanEst;
    String ano;
    String estado;

    PlanEstudiosModel({
        this.idPlanEst,
        this.ano,
        this.estado,
    });

    factory PlanEstudiosModel.fromJson(Map<String, dynamic> json) => PlanEstudiosModel(
        idPlanEst: json["idPlanEst"],
        ano: json["ano"],
        estado: json["estado"],
    );

    Map<String, dynamic> toJson() => {
        "idPlanEst": idPlanEst,
        "ano": ano,
        "estado": estado,
    };
}