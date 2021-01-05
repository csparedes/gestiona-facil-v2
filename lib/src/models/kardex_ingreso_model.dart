// To parse this JSON data, do
//
//     final kardexIngresoModel = kardexIngresoModelFromJson(jsonString);

import 'dart:convert';

KardexIngresoModel kardexIngresoModelFromJson(String str) =>
    KardexIngresoModel.fromJson(json.decode(str));

String kardexIngresoModelToJson(KardexIngresoModel data) =>
    json.encode(data.toJson());

class KardexIngresoModel {
  KardexIngresoModel({
    this.kiId,
    this.kiFechaIngreso,
    this.kiCantidad,
    this.kiValorUnitario,
    this.kiValorTotal,
    this.kiEstado,
    this.tblProductoProId,
    this.tblProducto,
  });

  int kiId;
  String kiFechaIngreso;
  int kiCantidad;
  double kiValorUnitario;
  int kiValorTotal;
  bool kiEstado;
  int tblProductoProId;
  TblProducto tblProducto;

  factory KardexIngresoModel.fromJson(Map<String, dynamic> json) =>
      KardexIngresoModel(
        kiId: json["kiId"],
        kiFechaIngreso: json["kiFechaIngreso"],
        kiCantidad: json["kiCantidad"],
        kiValorUnitario: json["kiValorUnitario"].toDouble(),
        kiValorTotal: json["kiValorTotal"],
        kiEstado: json["kiEstado"],
        tblProductoProId: json["tblProductoProId"],
        tblProducto: TblProducto.fromJson(json["tbl_producto"]),
      );

  Map<String, dynamic> toJson() => {
        "kiId": kiId,
        "kiFechaIngreso": kiFechaIngreso,
        "kiCantidad": kiCantidad,
        "kiValorUnitario": kiValorUnitario,
        "kiValorTotal": kiValorTotal,
        "kiEstado": kiEstado,
        "tblProductoProId": tblProductoProId,
        "tbl_producto": tblProducto.toJson(),
      };
}

class TblProducto {
  TblProducto({
    this.proId,
    this.proCodigoBarras,
    this.proNombre,
    this.proFoto,
    this.proEstado,
    this.tblCategoriumCatId,
  });

  int proId;
  String proCodigoBarras;
  String proNombre;
  String proFoto;
  bool proEstado;
  int tblCategoriumCatId;

  factory TblProducto.fromJson(Map<String, dynamic> json) => TblProducto(
        proId: json["proId"],
        proCodigoBarras: json["proCodigoBarras"],
        proNombre: json["proNombre"],
        proFoto: json["proFoto"],
        proEstado: json["proEstado"],
        tblCategoriumCatId: json["tblCategoriumCatId"],
      );

  Map<String, dynamic> toJson() => {
        "proId": proId,
        "proCodigoBarras": proCodigoBarras,
        "proNombre": proNombre,
        "proFoto": proFoto,
        "proEstado": proEstado,
        "tblCategoriumCatId": tblCategoriumCatId,
      };
}
