// To parse this JSON data, do
//
//     final categoriaModel = categoriaModelFromJson(jsonString);

import 'dart:convert';

CategoriaModel categoriaModelFromJson(String str) =>
    CategoriaModel.fromJson(json.decode(str));

String categoriaModelToJson(CategoriaModel data) => json.encode(data.toJson());

class CategoriaModel {
  CategoriaModel({
    this.catId,
    this.catNombre,
    this.catDescripcion,
    this.catEstado,
  });

  int catId;
  String catNombre;
  String catDescripcion;
  bool catEstado;

  factory CategoriaModel.fromJson(Map<String, dynamic> json) => CategoriaModel(
        catId: json["catId"],
        catNombre: json["catNombre"],
        catDescripcion: json["catDescripcion"],
        catEstado: json["catEstado"],
      );

  Map<String, dynamic> toJson() => {
        "catId": catId.toString(),
        "catNombre": catNombre,
        "catDescripcion": catDescripcion,
        "catEstado": catEstado.toString(),
      };
}
