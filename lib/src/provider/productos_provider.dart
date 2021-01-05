import 'dart:convert';

import 'package:flutter/material.dart';

// import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:dio/dio.dart';

import 'package:gestionafacil_v2/src/models/producto_model.dart';

class ProductosProvider with ChangeNotifier {
  List<int> _mostrarProductos = [1, 2, 3, 4, 5, 6];
  final String _url = 'http://192.168.1.39:3000/api/productos';
  // final String _url = 'http://10.0.2.2:3000/api/productos';

  get mostrarProductos {
    return _mostrarProductos.toString();
  }

  set mostrarProductos(List<int> productos) {
    this._mostrarProductos = productos;
    notifyListeners();
  }

  String mostrarListaProdutos() {
    return _mostrarProductos.toString();
  }

  Future<List<ProductoModel>> cargarProducto() async {
    final List<ProductoModel> listaProductos = new List<ProductoModel>();
    final url = '$_url';

    final consulta = await http.get(url);
    print(consulta.body.toString());

    final Map<String, dynamic> decodedData = jsonDecode(consulta.body);
    if (decodedData == null) return [];

    decodedData.forEach((key, value) {
      if (key == "productos") {
        // listaProductos.add(value);
        final List aux = value;
        aux.forEach((e) {
          final temp = ProductoModel.fromJson(e);
          listaProductos.add(temp);
        });
      }
    });

    return listaProductos;
  }
}
