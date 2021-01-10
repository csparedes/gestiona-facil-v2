import 'package:flutter/material.dart';
import 'package:gestionafacil_v2/src/models/kardex_existencia_model.dart';
import 'package:provider/provider.dart';

import 'package:gestionafacil_v2/src/provider/inventario_provider.dart';

class InventarioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final inventario = Provider.of<InventarioProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Inventario'),
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
              future: inventario.cargarKardexExistencias(),
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

                final List<KardexExistenciaModel> lista = snapshot.data;

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
                            Text(lista[i].keCantidad.toString()),
                          ],
                        ),
                        leading: Icon(Icons.face),
                        subtitle: Text(lista[i].keFechaCaducidad),
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
    );
  }
}
