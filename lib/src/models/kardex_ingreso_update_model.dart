// To parse this JSON data, do
//
//     final kardexIngresoUpdateModel = kardexIngresoUpdateModelFromJson(jsonString);

import 'dart:convert';

KardexIngresoUpdateModel kardexIngresoUpdateModelFromJson(String str) =>
    KardexIngresoUpdateModel.fromJson(json.decode(str));

String kardexIngresoUpdateModelToJson(KardexIngresoUpdateModel data) =>
    json.encode(data.toJson());

class KardexIngresoUpdateModel {
  KardexIngresoUpdateModel({
    this.kiId,
    this.kiFechaIngreso,
    this.kiFechaCaducidad,
    this.kiCantidad,
    this.kiValorUnitario,
    this.kiValorTotal,
    this.tblProductoProId,
  });

  int kiId;
  String kiFechaIngreso;
  String kiFechaCaducidad;
  int kiCantidad;
  double kiValorUnitario;
  double kiValorTotal;
  int tblProductoProId;

  factory KardexIngresoUpdateModel.fromJson(Map<String, dynamic> json) =>
      KardexIngresoUpdateModel(
        kiId: json["kiId"],
        kiFechaIngreso: json["kiFechaIngreso"],
        kiFechaCaducidad: json["kiFechaCaducidad"],
        kiCantidad: int.parse(json["kiCantidad"]),
        kiValorUnitario: double.parse(json["kiValorUnitario"]),
        kiValorTotal: double.parse(json["kiValorTotal"]),
        tblProductoProId: json["tblProductoProId"],
      );

  Map<String, dynamic> toJson() => {
        "kiId": kiId,
        "kiFechaIngreso": kiFechaIngreso,
        "kiFechaCaducidad": kiFechaCaducidad,
        "kiCantidad": kiCantidad,
        "kiValorUnitario": kiValorUnitario,
        "kiValorTotal": kiValorTotal,
        "tblProductoProId": tblProductoProId,
      };
}
