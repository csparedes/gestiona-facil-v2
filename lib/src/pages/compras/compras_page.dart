import 'package:flutter/material.dart';
import 'package:gestionafacil_v2/src/models/kardex_ingreso_model.dart';
import 'package:gestionafacil_v2/src/provider/compras_provider.dart';
import 'package:provider/provider.dart';

class ComprasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final compras = Provider.of<ComprasProvider>(context);
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
              future: compras.cargarKardexIngreso(),
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

                return SingleChildScrollView(
                  child: ListView.builder(
                    itemBuilder: (_, i) {
                      return ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(lista[i].tblProducto.proNombre),
                            Text(lista[i].kiCantidad.toString()),
                          ],
                        ),
                        leading: Icon(Icons.face),
                        subtitle: Text(lista[i].kiFechaIngreso),
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
