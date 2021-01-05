// To parse this JSON data, do
//
//     final encabezadoFacturaModel = encabezadoFacturaModelFromJson(jsonString);

import 'dart:convert';

EncabezadoFacturaModel encabezadoFacturaModelFromJson(String str) =>
    EncabezadoFacturaModel.fromJson(json.decode(str));

String encabezadoFacturaModelToJson(EncabezadoFacturaModel data) =>
    json.encode(data.toJson());

class EncabezadoFacturaModel {
  EncabezadoFacturaModel({
    this.efId,
    this.efFecha,
    this.efTotal,
    this.efObservacion,
    this.efIvaPorcentaje,
    this.efIvaValor,
    this.efEstado,
    this.tblClienteCliId,
    this.tblCliente,
  });

  int efId;
  String efFecha;
  int efTotal;
  String efObservacion;
  double efIvaPorcentaje;
  double efIvaValor;
  bool efEstado;
  int tblClienteCliId;
  TblCliente tblCliente;

  factory EncabezadoFacturaModel.fromJson(Map<String, dynamic> json) =>
      EncabezadoFacturaModel(
        efId: json["efId"],
        efFecha: json["efFecha"],
        efTotal: json["efTotal"],
        efObservacion: json["efObservacion"],
        efIvaPorcentaje: json["efIvaPorcentaje"].toDouble(),
        efIvaValor: json["efIvaValor"].toDouble(),
        efEstado: json["efEstado"],
        tblClienteCliId: json["tblClienteCliId"],
        tblCliente: TblCliente.fromJson(json["tbl_cliente"]),
      );

  Map<String, dynamic> toJson() => {
        "efId": efId,
        "efFecha": efFecha,
        "efTotal": efTotal,
        "efObservacion": efObservacion,
        "efIvaPorcentaje": efIvaPorcentaje,
        "efIvaValor": efIvaValor,
        "efEstado": efEstado,
        "tblClienteCliId": tblClienteCliId,
        "tbl_cliente": tblCliente.toJson(),
      };
}

class TblCliente {
  TblCliente({
    this.cliId,
    this.cliNombres,
    this.cliApellidos,
    this.cliIdentificacion,
    this.cliFechaNacimiento,
    this.cliDomicilio,
    this.cliCorreo,
    this.cliEstado,
  });

  int cliId;
  String cliNombres;
  String cliApellidos;
  String cliIdentificacion;
  String cliFechaNacimiento;
  String cliDomicilio;
  String cliCorreo;
  bool cliEstado;

  factory TblCliente.fromJson(Map<String, dynamic> json) => TblCliente(
        cliId: json["cliId"],
        cliNombres: json["cliNombres"],
        cliApellidos: json["cliApellidos"],
        cliIdentificacion: json["cliIdentificacion"],
        cliFechaNacimiento: json["cliFechaNacimiento"],
        cliDomicilio: json["cliDomicilio"],
        cliCorreo: json["cliCorreo"],
        cliEstado: json["cliEstado"],
      );

  Map<String, dynamic> toJson() => {
        "cliId": cliId,
        "cliNombres": cliNombres,
        "cliApellidos": cliApellidos,
        "cliIdentificacion": cliIdentificacion,
        "cliFechaNacimiento": cliFechaNacimiento,
        "cliDomicilio": cliDomicilio,
        "cliCorreo": cliCorreo,
        "cliEstado": cliEstado,
      };
}
