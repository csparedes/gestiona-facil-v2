// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

ProductoModelUpdate productoModelUpdateFromJson(String str) =>
    ProductoModelUpdate.fromJson(json.decode(str));

String productoModelUpdateToJson(ProductoModelUpdate data) =>
    json.encode(data.toJson());

class ProductoModelUpdate {
  ProductoModelUpdate({
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

  factory ProductoModelUpdate.fromJson(Map<String, dynamic> json) =>
      ProductoModelUpdate(
        proId: json["proId"],
        proCodigoBarras: json["proCodigoBarras"],
        proNombre: json["proNombre"],
        proFoto: json["proFoto"],
        proEstado: json["proEstado"],
        tblCategoriumCatId: json["tblCategoriumCatId"],
      );

  // Map<String, dynamic> toJson() => {
  //       "proId": proId,
  //       "proCodigoBarras": proCodigoBarras,
  //       "proNombre": proNombre,
  //       "proFoto": proFoto,
  //       "proEstado": proEstado,
  //       "tblCategoriumCatId": tblCategoriumCatId,
  //     };

  Map<String, String> toJson() => {
        "proId": proId.toString(),
        "proCodigoBarras": proCodigoBarras,
        "proNombre": proNombre,
        "proFoto": proFoto,
        "proEstado": proEstado.toString(),
        "tblCategoriumCatId": tblCategoriumCatId.toString(),
      };
}
