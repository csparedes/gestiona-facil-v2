// To parse this JSON data, do
//
//     final kardexExistenciaModel = kardexExistenciaModelFromJson(jsonString);

import 'dart:convert';

KardexExistenciaModel kardexExistenciaModelFromJson(String str) =>
    KardexExistenciaModel.fromJson(json.decode(str));

String kardexExistenciaModelToJson(KardexExistenciaModel data) =>
    json.encode(data.toJson());

class KardexExistenciaModel {
  KardexExistenciaModel({
    this.keId,
    this.keFechaCaducidad,
    this.keCantidad,
    this.keValorUnitario,
    this.keValorTotal,
    this.keEstado,
    this.tblProductoProId,
    this.tblProducto,
  });

  int keId;
  String keFechaCaducidad;
  int keCantidad;
  double keValorUnitario;
  double keValorTotal;
  bool keEstado;
  int tblProductoProId;
  TblProductoExistencia tblProducto;

  factory KardexExistenciaModel.fromJson(Map<String, dynamic> json) =>
      KardexExistenciaModel(
        keId: json["keId"],
        keFechaCaducidad: json["keFechaCaducidad"],
        keCantidad: json["keCantidad"],
        keValorUnitario: json["keValorUnitario"].toDouble(),
        keValorTotal: json["keValorTotal"].toDouble(),
        keEstado: json["keEstado"],
        tblProductoProId: json["tblProductoProId"],
        tblProducto: TblProductoExistencia.fromJson(json["tbl_producto"]),
      );

  Map<String, dynamic> toJson() => {
        "keId": keId,
        "keFechaCaducidad": keFechaCaducidad,
        "keCantidad": keCantidad,
        "keValorUnitario": keValorUnitario,
        "keValorTotal": keValorTotal,
        "keEstado": keEstado,
        "tblProductoProId": tblProductoProId,
        "tbl_producto": tblProducto == null
            ? new TblProductoExistencia()
            : tblProducto.toJson(),
      };
}

class TblProductoExistencia {
  TblProductoExistencia({
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

  factory TblProductoExistencia.fromJson(Map<String, dynamic> json) =>
      TblProductoExistencia(
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
