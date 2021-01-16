import 'package:flutter/material.dart';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:gestionafacil_v2/src/pages/ventas/widgets/rectangulo_widget.dart';
import 'package:gestionafacil_v2/src/provider/nueva_venta_provider.dart';
import 'package:gestionafacil_v2/src/validators/utils.dart';
import 'package:provider/provider.dart';

class NuevaVentaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final kardexProvider = Provider.of<NuevaVentaProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva Venta'),
      ),
      body: Center(
        child: Column(
          children: [
            SafeArea(
              child: Container(),
            ),
            // _listarProductos(context, productosProvider),
            // _listaProducto(context, productosProvider),
            _mostrarKardexSalidas(kardexProvider),
          ],
        ),
      ),
      bottomSheet: _mostrarTotalVenta(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.photo_camera),
        onPressed: () => _escanearCodigo(context, kardexProvider),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _escanearCodigo(
      BuildContext context, NuevaVentaProvider productosProvider) async {
    dynamic futureString = '';
    try {
      futureString = await BarcodeScanner.scan();
    } catch (e) {
      futureString = e.toString();
    }

    if (Utils.validador(futureString)) {
      productosProvider.cadenaRespuesta = futureString;
    } else {
      //TODO: Acomodar Snackbar
      // final snackBar =
      //     SnackBar(content: Text('Intente nuevamente con el producto'));
      // Scaffold.of(context).showSnackBar(snackBar);
    }

    print('Future: ' + futureString);
    //TODO Configurar la lógica de una venta
  }

  Widget _mostrarKardexSalidas(NuevaVentaProvider kardexProvider) {
    return Column(
      children: [
        FutureBuilder(
          future: kardexProvider.getLista(),
          builder: (_, snapshot) {
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

            final lista = snapshot.data;

            if (lista.length == 0) {
              return Center(
                child: Text('No hay información'),
              );
            }

            return SingleChildScrollView(
              child: ListView.builder(
                itemBuilder: (_, i) {
                  return ListTile(
                    title: Text(lista[i]),
                    leading: Icon(Icons.sanitizer),
                  );
                },
                itemCount: lista.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _mostrarTotalVenta() {
    return Container(
      height: 50,
      child: Row(
        children: [
          Rectangulo(),
          Expanded(
            child: Container(),
          ),
          Rectangulo(),
        ],
      ),
    );
  }
}
