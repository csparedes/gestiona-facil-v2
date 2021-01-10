import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:gestionafacil_v2/src/models/kardex_ingreso_model.dart';

class ComprasProvider with ChangeNotifier {
  final String _url = 'http://192.168.1.39:3000/api/kardexIngreso';
  // final String _url = 'http://192.168.1.11:3000/api/kardexIngreso';
  String _compras = 'Compras';

  get compras {
    return _compras;
  }

  set compras(String compras) {
    this._compras = compras;
    notifyListeners();
  }

  Future<List<KardexIngresoModel>> cargarKardexIngreso() async {
    final List<KardexIngresoModel> kardexIngreso =
        new List<KardexIngresoModel>();
    final url = '$_url';

    final consulta = await http.get(url);
    print(consulta.body.toString());

    final Map<String, dynamic> decodedData = jsonDecode(consulta.body);
    if (decodedData == null) return [];

    decodedData.forEach((key, value) {
      if (key == "kardex") {
        // listaProductos.add(value);
        final List aux = value;
        aux.forEach((e) {
          final temp = KardexIngresoModel.fromJson(e);
          kardexIngreso.add(temp);
        });
      }
    });

    return kardexIngreso;
  }
}
