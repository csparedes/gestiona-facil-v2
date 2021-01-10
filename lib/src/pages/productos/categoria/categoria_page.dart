import 'package:flutter/material.dart';
import 'package:gestionafacil_v2/src/models/categoria_model.dart';
import 'package:gestionafacil_v2/src/pages/productos/categoria/modal_categoria_widget.dart';
import 'package:gestionafacil_v2/src/provider/categorias_provider.dart';
import 'package:provider/provider.dart';

class CategoriaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoriaProvider = Provider.of<CategoriaProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorías'),
      ),
      body: _mostrarBody(categoriaProvider),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'categoriaDetalle');
        },
      ),
    );
  }

  _mostrarBody(CategoriaProvider categoriaProvider) {
    // categoria Provider
    return Center(
      child: Column(
        children: [
          FutureBuilder(
            future: categoriaProvider.cargarCategorias(),
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

              final List<CategoriaModel> lista = snapshot.data;

              if (lista.length == 0) {
                return Center(
                  child: Text('No hay información'),
                );
              }

              return SingleChildScrollView(
                child: ListView.builder(
                  itemBuilder: (_, i) {
                    return ListTile(
                      title: Text(lista[i].catNombre),
                      leading: Icon(Icons.face),
                      subtitle: Text(lista[i].catDescripcion),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => ModalCategoriaWidget(lista[i]),
                        );
                      },
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
    );
  }
}
