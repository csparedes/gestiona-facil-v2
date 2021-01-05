import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestionafacil_v2/src/models/kardex_salida_model.dart';

import 'package:http/http.dart' as http;

class VentasProvider with ChangeNotifier {
  String _ventas = 'Ventas';
  final String _url = 'http://192.168.1.39:3000/api/kardexSalida';

  get ventas {
    return _ventas;
  }

  set ventas(String ventas) {
    this._ventas = ventas;
    notifyListeners();
  }

  Future<List<KardexSalidaModel>> cargarKardexSalida() async {
    final List<KardexSalidaModel> kardexSalidas = new List<KardexSalidaModel>();
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
          final temp = KardexSalidaModel.fromJson(e);
          kardexSalidas.add(temp);
        });
      }
    });

    return kardexSalidas;
  }
}
