import 'package:flutter/material.dart';
import 'package:gestionafacil_v2/src/models/categoria_model.dart';
import 'package:gestionafacil_v2/src/provider/categorias_provider.dart';
import 'package:provider/provider.dart';

class CategoriaDetallePage extends StatefulWidget {
  @override
  _CategoriaDetallePageState createState() => _CategoriaDetallePageState();
}

class _CategoriaDetallePageState extends State<CategoriaDetallePage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  CategoriaModel categoria = new CategoriaModel();
  bool _estaGuardando = false;
  String _textoBoton = 'Guardar';
  @override
  Widget build(BuildContext context) {
    final CategoriaModel categoriaData =
        ModalRoute.of(context).settings.arguments;
    final categoriaProvider = Provider.of<CategoriaProvider>(context);

    if (categoriaData != null) {
      categoria = categoriaData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(categoria.catNombre == null
            ? 'Nueva Categoria'
            : categoria.catNombre),
      ),
      body: _mostrarBody(categoriaProvider, categoria),
    );
  }

  _mostrarBody(CategoriaProvider categoriaProvider, CategoriaModel categoria) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              //Aqui va cada elemento del formulario
              _mostrarNombre(categoria),
              _mostrarDescripcion(categoria),
              SizedBox(
                height: 5,
              ),
              _mostrarBoton(categoriaProvider, categoria),
            ],
          ),
        ),
      ),
    );
  }

  _mostrarNombre(CategoriaModel categoria) {
    return Container(
      child: TextFormField(
        initialValue: categoria.catNombre,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(labelText: 'Nombre de la Categoría'),
        onSaved: (value) => categoria.catNombre = value,
      ),
    );
  }

  _mostrarDescripcion(CategoriaModel categoria) {
    return Container(
      child: TextFormField(
        initialValue: categoria.catDescripcion,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(labelText: 'Descripcion de la Categoría'),
        onSaved: (value) => categoria.catDescripcion = value,
      ),
    );
  }

  _mostrarBoton(CategoriaProvider categoriaProvider, CategoriaModel categoria) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      icon: Icon(Icons.save),
      label: Text(_textoBoton),
      onPressed:
          (_estaGuardando) ? null : () => _submit(categoriaProvider, categoria),
      // onPressed: (_estaGuardando) ? null : _submit,
    );
  }

  void _submit(CategoriaProvider categoriaProvider, CategoriaModel categoria) {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();
    setState(() {
      _textoBoton = 'Espere por fa :v';
      _estaGuardando = true;
    });

    if (categoria.catId == null) {
      categoria.catId = 0;
      categoria.catEstado = true;
      print(categoria.toString());
      categoriaProvider.agregarCategoria(categoria);
    } else {
      categoriaProvider.editarCategoria(categoria);
    }

    setState(() {
      _textoBoton = 'Guardar';
      _estaGuardando = false;
    });
    // mostrarSnackBar(context, 'Registro Guardado...');
    Navigator.pop(context);
  }
}
