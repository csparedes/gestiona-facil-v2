import 'package:flutter/material.dart';
import 'package:gestionafacil_v2/src/models/producto_model.dart';
import 'package:provider/provider.dart';
import 'package:gestionafacil_v2/src/provider/productos_provider.dart';

class ProductosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final producto = Provider.of<ProductosProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Productos'),
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
              future: producto.cargarProducto(),
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

                final List<ProductoModel> lista = snapshot.data;

                if (lista.length == 0) {
                  return Center(
                    child: Text('No hay información'),
                  );
                }

                return SingleChildScrollView(
                  child: ListView.builder(
                    itemBuilder: (_, i) {
                      return ListTile(
                        title: Text(lista[i].proNombre),
                        leading: Icon(Icons.face),
                        subtitle: Text(lista[i].proCodigoBarras),
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
