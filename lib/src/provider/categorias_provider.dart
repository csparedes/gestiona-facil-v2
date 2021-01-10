import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:gestionafacil_v2/src/models/categoria_model.dart';

class CategoriaProvider with ChangeNotifier {
  final String _url = 'http://192.168.1.39:3000/api/categoria';

  Future<List<CategoriaModel>> cargarCategorias() async {
    final List<CategoriaModel> listaCategorias = new List<CategoriaModel>();
    final url = '$_url';

    final consulta = await http.get(url);
    print(consulta.body.toString());

    final Map<String, dynamic> decodedData = jsonDecode(consulta.body);
    if (decodedData == null) return [];

    decodedData.forEach((key, value) {
      if (key == "categorias") {
        // listaProductos.add(value);
        final List aux = value;
        aux.forEach((e) {
          final temp = CategoriaModel.fromJson(e);
          listaCategorias.add(temp);
        });
      }
    });
    // notifyListeners();
    return listaCategorias;
  }

  Future<bool> editarCategoria(CategoriaModel categoria) async {
    // _cabecera["token"] = UsuarioProvider.tokenNode;
    // print("Suceso en editar producto" + producto.mostrarProducto());
    // print(producto.toString());
    final url = '$_url/${categoria.catId}';
    print(url);
    final respuesta = await http.put(
      url,
      body: categoria.toJson(),
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

  Future<bool> agregarCategoria(CategoriaModel categoria) async {
    print('json-encode: ' + jsonEncode(categoria));

    final url = '$_url';
    final respuesta = await http.post(
      url,
      body: jsonEncode(categoria.toJson()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
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

  Future<List<CategoriaModel>> buscarCategoria(String query) async {
    final url = '$_url/find/$query';
    // _cabecera['token'] = UsuarioProvider.tokenNode;
    final respuesta = await http.get(
      url,
      // headers: _cabecera
    );

    final List<CategoriaModel> listaCategorias = new List<CategoriaModel>();

    final Map<String, dynamic> decodedData = jsonDecode(respuesta.body);

    if (decodedData == null) {
      return [];
    }
    // print('DecodedData: ' + decodedData.toString());

    decodedData.forEach((key, value) {
      if (key == "categorias") {
        // listaProductos.add(value);
        // print('Todos los valores' + value);
        final List aux = value;

        aux.forEach((e) {
          final temp = CategoriaModel.fromJson(e);
          listaCategorias.add(temp);
        });
      }
    });

    return listaCategorias;
  }

  Future<bool> eliminarCategoria(int id) async {
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
