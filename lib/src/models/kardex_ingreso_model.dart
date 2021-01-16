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
    this.kiFechaCaducidad,
    this.kiCantidad,
    this.kiValorUnitario,
    this.kiValorTotal,
    this.kiEstado,
    this.tblProductoProId,
    this.tblProductoIngreso,
  });

  int kiId;
  String kiFechaIngreso;
  String kiFechaCaducidad;
  int kiCantidad;
  double kiValorUnitario;
  double kiValorTotal;
  bool kiEstado;
  int tblProductoProId;
  TblProductoIngreso tblProductoIngreso;

  factory KardexIngresoModel.fromJson(Map<String, dynamic> json) =>
      KardexIngresoModel(
        kiId: json["kiId"],
        kiFechaIngreso: json["kiFechaIngreso"],
        kiFechaCaducidad: json["kiFechaCaducidad"],
        kiCantidad: json["kiCantidad"],
        kiValorUnitario: json["kiValorUnitario"].toDouble(),
        kiValorTotal: json["kiValorTotal"].toDouble(),
        kiEstado: json["kiEstado"],
        tblProductoProId: json["tblProductoProId"],
        tblProductoIngreso: TblProductoIngreso.fromJson(json["tbl_producto"]),
      );

  Map<String, dynamic> toJson() => {
        "kiId": kiId,
        "kiFechaIngreso": kiFechaIngreso,
        "kiFechaCaducidad": kiFechaCaducidad,
        "kiCantidad": kiCantidad,
        "kiValorUnitario": kiValorUnitario,
        "kiValorTotal": kiValorTotal,
        "kiEstado": kiEstado,
        "tblProductoProId": tblProductoProId,
        "tbl_producto": tblProductoIngreso.toJson(),
      };
}

class TblProductoIngreso {
  TblProductoIngreso({
    this.proId,
    this.proCodigoBarras,
    this.proNombre,
    this.proFoto,
    this.proEstado,
    this.proPrecioVenta,
    this.tblCategoriumCatId,
  });

  int proId;
  String proCodigoBarras;
  String proNombre;
  String proFoto;
  bool proEstado;
  double proPrecioVenta;
  int tblCategoriumCatId;

  factory TblProductoIngreso.fromJson(Map<String, dynamic> json) =>
      TblProductoIngreso(
        proId: json["proId"],
        proCodigoBarras: json["proCodigoBarras"],
        proNombre: json["proNombre"],
        proFoto: json["proFoto"],
        proEstado: json["proEstado"],
        proPrecioVenta: json["proPrecioVenta"].toDouble(),
        tblCategoriumCatId: json["tblCategoriumCatId"],
      );

  Map<String, dynamic> toJson() => {
        "proId": proId,
        "proCodigoBarras": proCodigoBarras,
        "proNombre": proNombre,
        "proFoto": proFoto,
        "proEstado": proEstado,
        "proPrecioVenta": proPrecioVenta,
        "tblCategoriumCatId": tblCategoriumCatId,
      };
}
