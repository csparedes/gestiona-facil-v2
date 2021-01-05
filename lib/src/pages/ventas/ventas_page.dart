import 'package:flutter/material.dart';
import 'package:gestionafacil_v2/src/models/kardex_salida_model.dart';
import 'package:provider/provider.dart';

import 'package:gestionafacil_v2/src/provider/ventas_provider.dart';

class VentasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ventas = Provider.of<VentasProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Ventas'),
        actions: [
          IconButton(
            icon: Icon(Icons.find_in_page),
            onPressed: () {},
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            FutureBuilder(
              future: ventas.cargarKardexSalida(),
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

                final List<KardexSalidaModel> lista = snapshot.data;

                if (lista.length == 0) {
                  return Center(
                    child: Text('No hay información'),
                  );
                }

                return SingleChildScrollView(
                  child: ListView.builder(
                    itemBuilder: (_, i) {
                      return ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(lista[i].tblProducto.proNombre),
                            Text(lista[i].ksCantidad.toString()),
                          ],
                        ),
                        leading: Icon(Icons.face),
                        subtitle: Text(lista[i].ksFechaSalida),
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'nuevaVenta');
        },
      ),
    );
  }
}
