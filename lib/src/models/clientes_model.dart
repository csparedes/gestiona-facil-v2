// To parse this JSON data, do
//
//     final clientesModel = clientesModelFromJson(jsonString);

import 'dart:convert';

ClientesModel clientesModelFromJson(String str) =>
    ClientesModel.fromJson(json.decode(str));

String clientesModelToJson(ClientesModel data) => json.encode(data.toJson());

class ClientesModel {
  ClientesModel({
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
  DateTime cliFechaNacimiento;
  String cliDomicilio;
  String cliCorreo;
  bool cliEstado;

  factory ClientesModel.fromJson(Map<String, dynamic> json) => ClientesModel(
        cliId: json["cliId"],
        cliNombres: json["cliNombres"],
        cliApellidos: json["cliApellidos"],
        cliIdentificacion: json["cliIdentificacion"],
        cliFechaNacimiento: DateTime.parse(json["cliFechaNacimiento"]),
        cliDomicilio: json["cliDomicilio"],
        cliCorreo: json["cliCorreo"],
        cliEstado: json["cliEstado"],
      );

  Map<String, dynamic> toJson() => {
        "cliId": cliId,
        "cliNombres": cliNombres,
        "cliApellidos": cliApellidos,
        "cliIdentificacion": cliIdentificacion,
        "cliFechaNacimiento": cliFechaNacimiento.toIso8601String(),
        "cliDomicilio": cliDomicilio,
        "cliCorreo": cliCorreo,
        "cliEstado": cliEstado,
      };
}
