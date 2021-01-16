// To parse this JSON data, do
//
//     final kardexExistenciaModel = kardexExistenciaModelFromJson(jsonString);

import 'dart:convert';

KardexExistenciaUpdateModel kardexExistenciaModelFromJson(String str) =>
    KardexExistenciaUpdateModel.fromJson(json.decode(str));

String kardexExistenciaModelToJson(KardexExistenciaUpdateModel data) =>
    json.encode(data.toJson());

class KardexExistenciaUpdateModel {
  KardexExistenciaUpdateModel({
    this.keId,
    this.keFechaCaducidad,
    this.keCantidad,
    this.keValorUnitario,
    this.keValorTotal,
    this.keEstado,
    this.tblProductoProId,
  });

  int keId;
  String keFechaCaducidad;
  int keCantidad;
  double keValorUnitario;
  double keValorTotal;
  bool keEstado;
  int tblProductoProId;

  factory KardexExistenciaUpdateModel.fromJson(Map<String, dynamic> json) =>
      KardexExistenciaUpdateModel(
        keId: json["keId"],
        keFechaCaducidad: json["keFechaCaducidad"],
        keCantidad: json["keCantidad"],
        keValorUnitario: json["keValorUnitario"].toDouble(),
        keValorTotal: json["keValorTotal"].toDouble(),
        keEstado: json["keEstado"],
        tblProductoProId: json["tblProductoProId"],
      );

  Map<String, dynamic> toJson() => {
        "keId": keId,
        "keFechaCaducidad": keFechaCaducidad,
        "keCantidad": keCantidad,
        "keValorUnitario": keValorUnitario,
        "keValorTotal": keValorTotal,
        "keEstado": keEstado,
        "tblProductoProId": tblProductoProId,
      };
}
