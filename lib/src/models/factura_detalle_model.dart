// To parse this JSON data, do
//
//     final facturaDetalleModel = facturaDetalleModelFromJson(jsonString);

import 'dart:convert';

FacturaDetalleModel facturaDetalleModelFromJson(String str) =>
    FacturaDetalleModel.fromJson(json.decode(str));

String facturaDetalleModelToJson(FacturaDetalleModel data) =>
    json.encode(data.toJson());

class FacturaDetalleModel {
  FacturaDetalleModel({
    this.fdId,
    this.fdCantidad,
    this.fdValorUnitario,
    this.fdValorTotal,
    this.fdEstado,
    this.tblProductoProId,
    this.tblEncabezadoFacturaEfId,
    this.tblProducto,
  });

  int fdId;
  int fdCantidad;
  double fdValorUnitario;
  double fdValorTotal;
  bool fdEstado;
  int tblProductoProId;
  int tblEncabezadoFacturaEfId;
  TblProducto tblProducto;

  factory FacturaDetalleModel.fromJson(Map<String, dynamic> json) =>
      FacturaDetalleModel(
        fdId: json["fdId"],
        fdCantidad: json["fdCantidad"],
        fdValorUnitario: json["fdValorUnitario"].toDouble(),
        fdValorTotal: json["fdValorTotal"].toDouble(),
        fdEstado: json["fdEstado"],
        tblProductoProId: json["tblProductoProId"],
        tblEncabezadoFacturaEfId: json["tblEncabezadoFacturaEfId"],
        tblProducto: TblProducto.fromJson(json["tbl_producto"]),
      );

  Map<String, dynamic> toJson() => {
        "fdId": fdId,
        "fdCantidad": fdCantidad,
        "fdValorUnitario": fdValorUnitario,
        "fdValorTotal": fdValorTotal,
        "fdEstado": fdEstado,
        "tblProductoProId": tblProductoProId,
        "tblEncabezadoFacturaEfId": tblEncabezadoFacturaEfId,
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
