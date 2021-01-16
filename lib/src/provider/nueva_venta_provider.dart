import 'package:flutter/material.dart';
import 'dart:async';

class NuevaVentaProvider with ChangeNotifier {
  List<String> _listaVenta = [];
  String _cadenaRespuesta = '';
  //stream
  final _productosController = new StreamController<List<String>>.broadcast();
  //sink
  Function(List<String>) get productosSink => _productosController.sink.add;
  //stream
  Stream<List<String>> get productoStream => _productosController.stream;
  //dispose
  void disposeStream() => _productosController.close();

  get cadenaRespuesta {
    return _cadenaRespuesta;
  }

  set cadenaRespuesta(String codigo) {
    _listaVenta.add(codigo);
    productosSink(_listaVenta);
    notifyListeners();
  }

  get listaVenta {
    return _listaVenta.toString();
  }

  set listaVenta(List<String> lista) {
    this._listaVenta = lista;
    notifyListeners();
  }

  Future<List<String>> getLista() async {
    print(
        '========================================\n' + _listaVenta.toString());
    return _listaVenta;
  }
}
