// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

ProductoModel productoModelFromJson(String str) =>
    ProductoModel.fromJson(json.decode(str));

String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
  ProductoModel({
    this.proId,
    this.proCodigoBarras,
    this.proNombre,
    this.proFoto,
    this.proEstado,
    this.tblCategoriumCatId,
    this.tblCategorium,
  });

  int proId;
  String proCodigoBarras;
  String proNombre;
  String proFoto;
  bool proEstado;
  int tblCategoriumCatId;
  TblCategorium tblCategorium;

  factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        proId: json["proId"],
        proCodigoBarras: json["proCodigoBarras"],
        proNombre: json["proNombre"],
        proFoto: json["proFoto"],
        proEstado: json["proEstado"],
        tblCategoriumCatId: json["tblCategoriumCatId"],
        tblCategorium: TblCategorium.fromJson(json["tbl_categorium"]),
      );

  Map<String, dynamic> toJson() => {
        "proId": proId,
        "proCodigoBarras": proCodigoBarras,
        "proNombre": proNombre,
        "proFoto": proFoto,
        "proEstado": proEstado,
        "tblCategoriumCatId": tblCategoriumCatId,
        "tbl_categorium":
            (tblCategorium == null) ? null : tblCategorium.toJson(),
      };
}

class TblCategorium {
  TblCategorium({
    this.catId,
    this.catNombre,
    this.catDescripcion,
    this.catEstado,
  });

  int catId;
  String catNombre;
  String catDescripcion;
  bool catEstado;

  factory TblCategorium.fromJson(Map<String, dynamic> json) => TblCategorium(
        catId: json["catId"],
        catNombre: json["catNombre"],
        catDescripcion: json["catDescripcion"],
        catEstado: json["catEstado"],
      );

  Map<String, dynamic> toJson() => {
        "catId": catId,
        "catNombre": catNombre,
        "catDescripcion": catDescripcion,
        "catEstado": catEstado,
      };
}
