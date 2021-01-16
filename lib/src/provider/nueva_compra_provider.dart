import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestionafacil_v2/src/models/kardex_existencia_model.dart';
import 'package:gestionafacil_v2/src/models/kardex_existencia_update_model.dart';
// import 'package:gestionafacil_v2/src/models/kardex_existencia_model.dart';
import 'package:gestionafacil_v2/src/models/kardex_ingreso_model.dart';
import 'package:gestionafacil_v2/src/models/kardex_ingreso_update_model.dart';
import 'package:gestionafacil_v2/src/validators/utils.dart';
import 'package:http/http.dart' as http;

class NuevaCompraProvider with ChangeNotifier {
  final String _url = 'http://192.168.1.39:3000';
  List<String> _listaCodigos = [];
  List<KardexIngresoModel> _listaIngresos = new List<KardexIngresoModel>();
  String _cadenaRespuesta = '';
  //stream
  final _kardexController = new StreamController<List<String>>.broadcast();
  final _ingresosController =
      new StreamController<List<KardexIngresoModel>>.broadcast();
  //sink
  Function(List<String>) get productosSink => _kardexController.sink.add;
  Function(List<KardexIngresoModel>) get ingresosSink =>
      _ingresosController.sink.add;
  //stream
  Stream<List<String>> get productoStream => _kardexController.stream;
  Stream<List<KardexIngresoModel>> get ingresosStream =>
      _ingresosController.stream;
  //dispose
  void disposeStream() {
    _ingresosController.close();
    _kardexController.close();
  }

  get listaCodigos {
    return _cadenaRespuesta;
  }

  set listaCodigos(String codigo) {
    _listaCodigos.add(codigo);
    productosSink(_listaCodigos);
    notifyListeners();
  }

  get listaCompra {
    return _listaCodigos.toString();
  }

  set listaCompra(List<String> lista) {
    this._listaCodigos = lista;
    notifyListeners();
  }

  Future<List<String>> getLista() async {
    return _listaCodigos;
  }

  // void convertirProductosCodigos() async {
  //   _listaCodigos.forEach((value) async {
  //     String url = '$_url/api/productos/findCodigo/$value';
  //     //aux tiene el ID del producto
  //     final aux = await http.get('$url');
  //     final Map<String, dynamic> aux1 = jsonDecode(aux.body);
  //     final variable = aux1['producto']['proId'].toString();
  //     print('aux1: ' + variable);
  //     //temp tiene el kardex de ingreso
  //     final temp = await http.get('$_url/api/kardexIngreso/$variable');
  //     final Map<String, dynamic> kardex = jsonDecode(temp.body);
  //     print('BodyKardex: ' + kardex.toString());

  //     final producto = kardex['kardex'];
  //     final pro = KardexIngresoModel.fromJson(producto);
  //     print('producto: ' + pro.toString());
  //     _listaIngresos.add(pro);
  //   });
  // }

  void convertirProductoCodigo(String codigo) async {
    String url = '$_url/api/productos/findCodigo/$codigo';
    KardexIngresoModel pro = new KardexIngresoModel();
    //aux tiene el ID del producto
    final aux = await http.get('$url');
    final Map<String, dynamic> aux1 = jsonDecode(aux.body);
    final variable = aux1['producto']['proId'].toString();
    print('aux1: ' + variable);
    //temp tiene el kardex de ingreso
//     final temp = await http.get('$_url/api/kardexIngreso/$variable');
//     final Map<String, dynamic> kardex = jsonDecode(temp.body);
//     print('BodyKardex: ' + kardex.toString());
// //modificar fecha, cantidad, valor unitario, valor total**

//     final producto = kardex['kardex'];
//     final pro = KardexIngresoModel.fromJson(producto);
    //obtener fecha actual
    pro.tblProductoProId = int.parse(variable);
    pro.kiFechaIngreso = Utils.transformarFecha(DateTime.now());
    //cantidad a 1
    pro.kiCantidad = 1;
    pro.kiValorUnitario = 0.0;
    pro.kiValorTotal = pro.kiCantidad * pro.kiValorUnitario;
    pro.kiEstado = true;
    pro.kiId = 0;
    pro.tblProductoIngreso = TblProductoIngreso(
      proNombre: aux1['producto']['proNombre'] == null
          ? ''
          : aux1['producto']['proNombre'],
      proCodigoBarras: aux1['producto']['proCodigoBarras'],
      proFoto: aux1['producto']['proFoto'],
      tblCategoriumCatId: aux1['producto']['tblCategoriumCatId'],
    );
    // pro.tblProducto.proNombre = '';
    _listaIngresos.add(pro);
    notifyListeners();
  }

  void realizarCompraProductos() {
    _listaIngresos.forEach((value) {
      //agregar al kardex
      print('ListaCompras: ' + value.tblProductoIngreso.proNombre);
    });
  }

  void eliminarLista() {
    _listaIngresos.clear();
    notifyListeners();
  }

  Future<List<dynamic>> obtenerIngresos() async {
    // notifyListeners();
    return _listaIngresos;
  }

  void eliminarItem(int id) {
    _listaIngresos.removeAt(id);
    notifyListeners();
  }

  void editarIngreso(List<KardexIngresoModel> lista, int id, int cantidad,
      double precioUnitario) {
    lista[id].kiCantidad = cantidad;
    lista[id].kiValorUnitario = precioUnitario;
    lista[id].kiValorTotal = cantidad * precioUnitario;
    notifyListeners();
  }

  Future<double> sumaTotalCompra() async {
    double suma = 0.0;
    _listaIngresos.forEach((value) {
      suma += value.kiValorTotal;
    });
    return suma;
  }

  String mostrarListaString() {
    String salida = '';
    _listaIngresos.forEach((value) {
      salida += value.tblProductoIngreso.proNombre + '\n';
    });
    return salida;
  }

  void realizarVenta() {
    _listaIngresos.forEach((value) async {
      KardexIngresoUpdateModel nuevoKardex = new KardexIngresoUpdateModel();
      nuevoKardex.kiId = value.kiId;
      nuevoKardex.kiFechaIngreso = value.kiFechaIngreso;
      nuevoKardex.kiFechaCaducidad = value.kiFechaCaducidad;
      nuevoKardex.kiCantidad = value.kiCantidad;
      nuevoKardex.kiValorUnitario = value.kiValorUnitario;
      nuevoKardex.kiValorTotal = value.kiValorTotal;
      nuevoKardex.tblProductoProId = value.tblProductoProId;

      if (await agregarKardexIngreso(nuevoKardex)) {
        //agregar al kardex existencias
        await agregarKardexExistencias(nuevoKardex);
        print('success');
      }
      print('fail');
    });
  }

  Future<bool> agregarKardexIngreso(KardexIngresoUpdateModel kardex) async {
    final url = '$_url/api/kardexIngreso';

    final respuesta = await http.post(
      url,
      body: jsonEncode(kardex.toJson()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    notifyListeners();
    if (respuesta.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future agregarKardexExistencias(
      KardexIngresoUpdateModel kardexIngreso) async {
    KardexExistenciaUpdateModel kardexExistencia =
        new KardexExistenciaUpdateModel();

    kardexExistencia.keId = kardexIngreso.kiId;
    kardexExistencia.keFechaCaducidad = kardexIngreso.kiFechaCaducidad;
    kardexExistencia.keValorUnitario = kardexIngreso.kiValorUnitario;
    kardexExistencia.tblProductoProId = kardexIngreso.tblProductoProId;
    kardexExistencia.keEstado = true;
    //pendiente: cantidad y valor Total
    // kardexExistencia.
    final url1 = '$_url/api/kardexExistencia/${kardexIngreso.tblProductoProId}';
    final respuesta1 = await http.get(url1);

    Map<String, dynamic> decodedData = jsonDecode(respuesta1.body);
    decodedData.forEach((key, value) async {
      if (key == 'existencia') {
        //Si es null
        if (value == null) {
          //agregar
          kardexExistencia.keCantidad = kardexIngreso.kiCantidad;
          kardexExistencia.keValorTotal =
              kardexIngreso.kiCantidad * kardexIngreso.kiValorUnitario;
          crearExistencia(kardexExistencia);
        } else {
          //editar
          final KardexExistenciaUpdateModel kardexExistente =
              KardexExistenciaUpdateModel.fromJson(value);
          kardexExistente.keCantidad += kardexIngreso.kiCantidad;
          kardexExistente.keValorTotal =
              kardexExistente.keCantidad * kardexExistente.keValorUnitario;
          editarExistencia(kardexExistente);
        }
      }
    });
    notifyListeners();
  }

  Future crearExistencia(KardexExistenciaUpdateModel kardex) async {
    String url = '$_url/api/kardexExistencia';
    print('urlExistencias: ' + jsonEncode(kardex.toJson()));
    await http.post(
      url,
      body: jsonEncode(kardex.toJson()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    notifyListeners();
  }

  Future editarExistencia(KardexExistenciaUpdateModel kardex) async {
    String url = '$_url/api/kardexExistencia/${kardex.keId}';
    print('urlExistencias: ' + jsonEncode(kardex.toJson()));
    await http.put(
      url,
      body: jsonEncode(kardex.toJson()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    notifyListeners();
  }
}
