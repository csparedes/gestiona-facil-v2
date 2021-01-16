import 'package:flutter/material.dart';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:gestionafacil_v2/src/models/kardex_ingreso_model.dart';
import 'package:gestionafacil_v2/src/pages/compras/widgets/modal_compra_widget.dart';
import 'package:provider/provider.dart';

import 'package:gestionafacil_v2/src/provider/nueva_compra_provider.dart';
import 'package:gestionafacil_v2/src/validators/utils.dart';

class NuevaCompraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final kardexProvider = Provider.of<NuevaCompraProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva Compra - Lista'),
      ),
      body: Column(
        children: [
          // _mostrarBody(kardexProvider),
          _mostrarSuma(kardexProvider, size),
          _mostrarPrueba(kardexProvider, size.height),
        ],
      ),
      floatingActionButton: _mostrarBotonesFlotantes(context, kardexProvider),
    );
  }

  _escanearCodigo(
      BuildContext context, NuevaCompraProvider productosProvider) async {
    dynamic futureString = '';
    try {
      futureString = await BarcodeScanner.scan();
    } catch (e) {
      futureString = e.toString();
    }

    if (Utils.validador(futureString)) {
      productosProvider.listaCodigos = futureString;
      productosProvider.convertirProductoCodigo(futureString);
    } else {
      //TODO: Acomodar Snackbar
      print('excepcion: ' + futureString);
      final snackBar = SnackBar(
        content: Text('Incorrecto, intentelo de nuevo!'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Algo de código para ¡deshacer el cambio!
          },
        ),
      );

      Scaffold.of(context).showSnackBar(snackBar);
    }

    print('Future: ' + futureString);
    //TODO Configurar la lógica de una venta
  }

  // _mostrarBody(NuevaCompraProvider kardexProvider) {
  //   return Column(
  //     children: [
  //       FutureBuilder(
  //         future: kardexProvider.getLista(),
  //         builder: (_, snapshot) {
  //           if (!snapshot.hasData) {
  //             return Center(
  //               child: Column(
  //                 children: [
  //                   Container(
  //                     height: 400,
  //                   ),
  //                   CircularProgressIndicator(),
  //                 ],
  //               ),
  //             );
  //           }

  //           final lista = snapshot.data;

  //           if (lista.length == 0) {
  //             return Center(
  //               child: Text('No hay información'),
  //             );
  //           }

  //           return SingleChildScrollView(
  //             child: ListView.builder(
  //               itemBuilder: (_, i) {
  //                 return ListTile(
  //                   title: Text(lista[i]),
  //                   leading: Icon(Icons.sanitizer),
  //                 );
  //               },
  //               itemCount: lista.length,
  //               scrollDirection: Axis.vertical,
  //               shrinkWrap: true,
  //             ),
  //           );
  //         },
  //       ),
  //     ],
  //   );
  // }

  _mostrarPrueba(NuevaCompraProvider kardexProvider, double altura) {
    return Container(
      height: altura * 0.817,
      child: Container(
        child: FutureBuilder(
          future: kardexProvider.obtenerIngresos(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Column(
                  children: [
                    Container(
                      height: 400,
                    ),
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }

            final List<KardexIngresoModel> lista = snapshot.data;

            if (lista.length == 0) {
              return Center(
                child: Text('No hay información'),
              );
            }

            return ListView.builder(
              itemBuilder: (_, i) {
                return SingleChildScrollView(
                  child: Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direccion) => kardexProvider.eliminarItem(i),
                    background: Container(
                      alignment: Alignment.center,
                      color: Colors.red[400],
                      child: Text(
                        'Eliminar                                                Eliminar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    child: Container(
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: 'Cantidad: ',
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text: lista[i].kiCantidad.toString(),
                                        style: TextStyle(color: Colors.red)),
                                  ]),
                            ),
                            Text(
                              'Fecha: ' + lista[i].kiFechaIngreso,
                              style: TextStyle(fontSize: 19),
                            ),
                            Text('Nombre: ' +
                                lista[i].tblProductoIngreso.proNombre),
                            Text('Precio Unitario: ' +
                                lista[i].kiValorUnitario.toString()),
                            Text('Precio Total: ' +
                                lista[i].kiValorTotal.toString())
                          ],
                        ),
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.access_alarm),
                          ],
                        ),
                        subtitle: RichText(
                          text: TextSpan(
                              text: 'Caduca el: ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              children: [
                                TextSpan(
                                    text: lista[i].kiFechaCaducidad,
                                    style: TextStyle(color: Colors.green)),
                              ]),
                        ),
                        // trailing: IconButton(
                        //   icon: Icon(Icons.add),
                        //   onPressed: () {
                        //     // print('Id: '+ lista);
                        //   },
                        // ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => ModalCompraWidget(lista, i),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
              itemCount: lista.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
            );
          },
        ),
      ),
    );
  }

  _mostrarBotonesFlotantes(
      BuildContext context, NuevaCompraProvider kardexProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(
          width: 30.0,
        ),
        FloatingActionButton(
          heroTag: 'Boton de Compra 1',
          onPressed: () => kardexProvider.eliminarLista(),
          child: Icon(Icons.delete),
          backgroundColor: Colors.red,
        ),
        Expanded(
          child: SizedBox(
            width: 5.0,
          ),
        ),
        FloatingActionButton(
          heroTag: 'Boton de Compra 2',
          child: Icon(Icons.photo_camera),
          onPressed: () => _escanearCodigo(context, kardexProvider),
        ),
        Expanded(
          child: SizedBox(
            width: 5.0,
          ),
        ),
        FloatingActionButton(
          heroTag: 'Boton de Compra 3',
          onPressed: () async {
            //Realizar una venta
            print('Lista ' + kardexProvider.mostrarListaString());
            kardexProvider.realizarVenta();
            kardexProvider.eliminarLista();
            Navigator.pop(context);
          },
          child: Icon(Icons.check),
          backgroundColor: Colors.green,
        ),
        SizedBox(
          width: 5.0,
        ),
      ],
    );
  }

  _mostrarSuma(NuevaCompraProvider kardexProvider, Size size) {
    return Container(
      height: size.height * 0.08,
      width: size.width,
      color: Colors.red,
      // child: Text(kardexProvider.sumaTotalCompra().toString()),
      child: FutureBuilder(
        future: kardexProvider.sumaTotalCompra(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Text('Sin info');
          }
          double suma = snapshot.data;
          print('suma: ' + suma.toString());

          return Text(
            suma.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          );
        },
      ),
    );
  }
}
