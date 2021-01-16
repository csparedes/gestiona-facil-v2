import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestionafacil_v2/src/models/kardex_ingreso_update_model.dart';

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

  Future<List<KardexIngresoModel>> cargarKI() async {
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

  Future<KardexIngresoModel> cargarCodigoKI(String id) async {
    KardexIngresoModel kardex = new KardexIngresoModel();
    final url = '$_url/$id';

    final consulta = await http.get(url);
    // print(consulta.body.toString());

    final Map<String, dynamic> decodedData = jsonDecode(consulta.body);
    if (decodedData == null) return null;

    decodedData.forEach((key, value) {
      if (key == "kardex") {
        // listaProductos.add(value);
        print('ValueKardex:' + value.toString());
        // kardex = value;
      }
    });

    return kardex;
  }

  Future<bool> editarKI(KardexIngresoUpdateModel kardex) async {
    // _cabecera["token"] = UsuarioProvider.tokenNode;
    // print("Suceso en editar producto" + producto.mostrarProducto());
    // print(producto.toString());
    final url = '$_url/${kardex.kiId}';
    print(url);
    final respuesta = await http.put(
      url,
      body: kardex.toJson(),
      // headers: _cabecera,
    );
    final decodedData = jsonDecode(respuesta.body);
    print("Respuesta de editar producto: $decodedData");
    notifyListeners();
    if (respuesta.statusCode == 200) {
      print('editado con éxito');
      return true;
    }
    return false;
    // print("Status Code: ${respuesta.statusCode}");
  }

  Future<bool> agregarKI(KardexIngresoUpdateModel kardex) async {
    // print("instancia de crear Producto: " + producto.mostrarProducto());

    // _cabecera["token"] = UsuarioProvider.tokenNode;

    final url = '$_url';
    final respuesta = await http.post(
      url,
      body: kardex.toJson(),
      // headers: _cabecera,
    );
    notifyListeners();
    if (respuesta.statusCode == 200) {
      print('exito');
      print(respuesta.body.toString());
      return true;
    } else {
      print('fail');
      return false;
    }

    // final aux = json.decode(respuesta.body);
  }

  Future<bool> eliminarKI(int id) async {
    final url = '$_url/$id';
    final resp = await http.delete(url);
    print(resp.body.toString());
    notifyListeners();
    if (resp.statusCode == 200) {
      print('Se ha eliminado con éxito');
      return true;
    } else {
      return false;
    }
  }
}
