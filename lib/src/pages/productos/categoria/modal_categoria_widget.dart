import 'package:flutter/material.dart';
import 'package:gestionafacil_v2/src/models/categoria_model.dart';
import 'package:gestionafacil_v2/src/provider/categorias_provider.dart';
// import 'package:gestionafacil_v2/src/models/producto_model.dart';
// import 'package:path/path.dart';
import 'package:provider/provider.dart';
// import 'package:gestionafacil_v2/src/provider/productos_provider.dart';
// import 'package:provider/provider.dart';

class ModalCategoriaWidget extends StatelessWidget {
  final CategoriaModel categoria;

  ModalCategoriaWidget(this.categoria);
  @override
  Widget build(BuildContext context) {
    final categoriaProvider = Provider.of<CategoriaProvider>(context);
    return AlertDialog(
      title: Text(categoria.catNombre),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Text(categoria.catNombre),
                        Text(categoria.catDescripcion),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      actions: [
        FlatButton(
          child: Text(
            'Eliminar',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text('Esta Segur@?'),
                actions: [
                  FlatButton(
                    child: Text(
                      'Si',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    onPressed: () {
                      //TODO: implementar el eliminar producto
                      categoriaProvider.eliminarCategoria(categoria.catId);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        ),
        FlatButton(
          child: Text('Editar'),
          onPressed: () {
            Navigator.pushNamed(context, 'categoriaDetalle',
                arguments: categoria);
          },
        )
      ],
    );
  }
}
