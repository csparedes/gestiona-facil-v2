// To parse this JSON data, do
//
//     final categoriaGetModel = categoriaGetModelFromJson(jsonString);

import 'dart:convert';

CategoriaGetModel categoriaGetModelFromJson(String str) =>
    CategoriaGetModel.fromJson(json.decode(str));

String categoriaGetModelToJson(CategoriaGetModel data) =>
    json.encode(data.toJson());

class CategoriaGetModel {
  CategoriaGetModel({
    this.catId,
    this.catNombre,
  });

  int catId;
  String catNombre;

  factory CategoriaGetModel.fromJson(Map<String, dynamic> json) =>
      CategoriaGetModel(
        catId: json["catId"],
        catNombre: json["catNombre"],
      );

  Map<String, dynamic> toJson() => {
        "catId": catId,
        "catNombre": catNombre,
      };
}
