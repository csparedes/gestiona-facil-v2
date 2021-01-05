// To parse this JSON data, do
//
//     final kardexSalidaModel = kardexSalidaModelFromJson(jsonString);

import 'dart:convert';

KardexSalidaModel kardexSalidaModelFromJson(String str) =>
    KardexSalidaModel.fromJson(json.decode(str));

String kardexSalidaModelToJson(KardexSalidaModel data) =>
    json.encode(data.toJson());

class KardexSalidaModel {
  KardexSalidaModel({
    this.ksId,
    this.ksFechaSalida,
    this.ksCantidad,
    this.ksValorUnitario,
    this.ksValorTotal,
    this.ksEstado,
    this.tblProductoProId,
    this.tblProducto,
  });

  int ksId;
  String ksFechaSalida;
  int ksCantidad;
  double ksValorUnitario;
  double ksValorTotal;
  bool ksEstado;
  int tblProductoProId;
  TblProducto tblProducto;

  factory KardexSalidaModel.fromJson(Map<String, dynamic> json) =>
      KardexSalidaModel(
        ksId: json["ksId"],
        ksFechaSalida: json["ksFechaSalida"],
        ksCantidad: json["ksCantidad"],
        ksValorUnitario: double.parse(json["ksValorUnitario"].toString()),
        ksValorTotal: double.parse(json["ksValorTotal"].toString()),
        ksEstado: json["ksEstado"],
        tblProductoProId: json["tblProductoProId"],
        tblProducto: TblProducto.fromJson(json["tbl_producto"]),
      );

  Map<String, dynamic> toJson() => {
        "ksId": ksId,
        "ksFechaSalida": ksFechaSalida,
        "ksCantidad": ksCantidad,
        "ksValorUnitario": ksValorUnitario,
        "ksValorTotal": ksValorTotal,
        "ksEstado": ksEstado,
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
