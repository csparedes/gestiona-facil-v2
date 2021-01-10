import 'package:flutter/material.dart';
import 'package:gestionafacil_v2/src/models/producto_model.dart';
import 'package:gestionafacil_v2/src/provider/productos_provider.dart';
// import 'package:path/path.dart';
import 'package:provider/provider.dart';
// import 'package:gestionafacil_v2/src/provider/productos_provider.dart';
// import 'package:provider/provider.dart';

class ModalWidget extends StatelessWidget {
  final ProductoModel producto;

  ModalWidget(this.producto);
  @override
  Widget build(BuildContext context) {
    final productoProvider = Provider.of<ProductosProvider>(context);
    return AlertDialog(
      title: Text(producto.proNombre),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _mostrarFoto(),
              _mostrarCodigoBarras(context),
              _mostrarCategoria(context)
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
                      productoProvider.eliminarProducto(producto.proId);
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
            Navigator.pushNamed(context, 'productoDetalle',
                arguments: producto);
          },
        )
      ],
    );
  }

  _mostrarFoto() {
    if (producto.proFoto != null) {
      return Container(
        child: FadeInImage(
            placeholder: AssetImage('assets/jar-loading.gif'),
            image: NetworkImage(producto.proFoto)),
      );
    } else {
      return Image.asset('assets/no-image.png');
    }
  }

  _mostrarCodigoBarras(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Text('Código: '),
          Expanded(
            child: Container(),
          ),
          Text(
            producto.proCodigoBarras,
            style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  _mostrarCategoria(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Text('Categoría: '),
          Expanded(
            child: Container(),
          ),
          Text(
            producto.tblCategorium.catNombre,
            style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
