import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:gestionafacil_v2/src/models/kardex_existencia_model.dart';

class InventarioProvider with ChangeNotifier {
  final String _url = 'http://192.168.1.39:3000/api/kardexExistencia';
  // final String _url = 'http://192.168.1.11:3000/api/kardexExistencia';
  String _inventario = 'Inventario';

  get inventario {
    return _inventario;
  }

  set inventario(String inventario) {
    this._inventario = inventario;
    notifyListeners();
  }

  Future<List<KardexExistenciaModel>> cargarKardexExistencias() async {
    final List<KardexExistenciaModel> kardexExistencias =
        new List<KardexExistenciaModel>();
    final url = '$_url';

    final consulta = await http.get(url);
    print(consulta.body.toString());

    final Map<String, dynamic> decodedData = jsonDecode(consulta.body);
    if (decodedData == null) return [];

    decodedData.forEach((key, value) {
      if (key == "existencias") {
        // listaProductos.add(value);
        final List aux = value;
        aux.forEach((e) {
          final temp = KardexExistenciaModel.fromJson(e);
          kardexExistencias.add(temp);
        });
      }
    });

    return kardexExistencias;
  }
}
