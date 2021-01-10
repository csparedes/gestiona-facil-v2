import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:gestionafacil_v2/src/models/categoria_get_model.dart';
// import 'package:gestionafacil_v2/src/models/categoria_model.dart';
import 'package:gestionafacil_v2/src/models/producto_model%20_update.dart';

import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

import 'package:gestionafacil_v2/src/models/producto_model.dart';

class ProductosProvider with ChangeNotifier {
  // List<int> _mostrarProductos = [1, 2, 3, 4, 5, 6];
  List _listitaCategorias = new List();
  // List<CategoriaGetModel> _listitaCategorias = [];

  get listitaCategorias {
    listaCategoriasDrop();
    print('listita: del getter' + _listitaCategorias.toString());
    return _listitaCategorias;
  }

  // set listitaCategorias(String cat) {
  //   _listitaCategorias.add(cat);
  //   notifyListeners();
  // }

  final String _url = 'http://192.168.1.39:3000/api/productos';
  // final String _url = 'http://192.168.1.11:3000/api/productos';
  // final String _url = 'http://10.0.2.2:3000/api/productos';

  // Map<String, String> _cabecera = {
  //   "Accept": "*/*",
  //   "Content-type": "application/x-www-form-urlencoded; charset=UTF-8"
  // };

  Future<String> subirImagen(File imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dhulr5xwe/image/upload?upload_preset=b1tntub8');

    final mimeType = mime(imagen.path).split('/');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath(
      'file',
      imagen.path,
      contentType: MediaType(mimeType[0], mimeType[1]),
    );

    imageUploadRequest.files.add(file);

    final stramResponse = await imageUploadRequest.send();

    final resp = await http.Response.fromStream(stramResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    print("Link de foto:\n" + respData['secure_url']);
    // notifyListeners();
    return respData['secure_url'];
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
    // notifyListeners();
    return listaProductos;
  }

  Future<bool> editarProducto(ProductoModelUpdate producto) async {
    // _cabecera["token"] = UsuarioProvider.tokenNode;
    // print("Suceso en editar producto" + producto.mostrarProducto());
    // print(producto.toString());
    final url = '$_url/${producto.proId}';
    print(url);
    final respuesta = await http.put(
      url,
      body: producto.toJson(),
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

  Future<bool> agregarProducto(ProductoModelUpdate producto) async {
    // print("instancia de crear Producto: " + producto.mostrarProducto());

    // _cabecera["token"] = UsuarioProvider.tokenNode;
    print('json-encode: ' + jsonEncode(producto));

    final url = '$_url';
    final respuesta = await http.post(
      url,
      body: producto.toJson(),
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

  Future<List<ProductoModel>> buscarProducto(String query) async {
    final url = '$_url/find/$query';
    // _cabecera['token'] = UsuarioProvider.tokenNode;
    final respuesta = await http.get(
      url,
      // headers: _cabecera
    );

    final List<ProductoModel> listaProductos = new List<ProductoModel>();

    final Map<String, dynamic> decodedData = jsonDecode(respuesta.body);

    if (decodedData == null) {
      return [];
    }
    // print('DecodedData: ' + decodedData.toString());

    decodedData.forEach((key, value) {
      if (key == "productos") {
        // listaProductos.add(value);
        // print('Todos los valores' + value);
        final List aux = value;

        aux.forEach((e) {
          final temp = ProductoModel.fromJson(e);
          listaProductos.add(temp);
        });
      }
    });

    return listaProductos;
  }

  Future<bool> eliminarProducto(int id) async {
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

  void listaCategoriasDrop() async {
    // List<String> lista = new List<String>();

    print('antes' + _listitaCategorias.toString());

    final resp = await http.get('http://192.168.1.39:3000/api/categoria/cat');

    print('en la consulta' + _listitaCategorias.toString());
    print('en la consulta' + resp.body);
    if (resp.statusCode == 200) {
      final Map<String, dynamic> decodedData = jsonDecode(resp.body);

      decodedData.forEach((key, value) {
        if (key == "categorias") {
          // listaProductos.add(value);
          // final List<CategoriaGetModel> aux = value;
          print('decoded' + _listitaCategorias.toString());
          // final List aux = value;
          // aux.forEach((e) {
          //   // final temp = e.
          //   print('eeeee' + e.toString());
          //   _listitaCategorias.add(e);
          //   print('despues' + _listitaCategorias.toString());
          // });
          _listitaCategorias = value;

          // listitaCategorias = aux;
          print('listita final' + _listitaCategorias.toString());
        }
      });
    }
  }
}
