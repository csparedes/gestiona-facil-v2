import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:gestionafacil_v2/src/models/producto_model%20_update.dart';
import 'package:gestionafacil_v2/src/provider/productos_provider.dart';
import 'package:gestionafacil_v2/src/validators/utils.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:gestionafacil_v2/src/models/producto_model.dart';
import 'package:provider/provider.dart';

class ProductoDetallePage extends StatefulWidget {
  @override
  _ProductoDetallePageState createState() => _ProductoDetallePageState();
}

class _ProductoDetallePageState extends State<ProductoDetallePage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // String codigoTemporal = 'Sin código';
  ProductoModel producto = new ProductoModel();
  bool _estaGuardando = false;
  File foto;
  String _textoBoton = 'Guardar';
  final picker = ImagePicker();
  //Variables globales dropdown
  String auxString;
  int auxIdCat;

  List<dynamic> listCategory = new List<dynamic>();
  @override
  void initState() {
    // ProductosProvider.listaCategoriasDropReturn(listCategory);
    // print('init: ' + listCategory.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;
    final productoProvider = Provider.of<ProductosProvider>(context);

    // List<String> listaCategorias = productoProvider.listitaCategorias;
    productoProvider.listaCategoriasDrop();
    // final listaCategorias = listCategory;
    setState(() {});
    // print('build: ' + listaCategorias.toString());
    if (prodData != null) {
      producto = prodData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text((producto.proNombre == null)
            ? 'Nuevo Producto'
            : producto.proNombre),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarFoto,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                //Aqui va cada elemento del formulario
                _mostrarFoto(),
                _mostrarNombre(),
                SizedBox(
                  height: 15,
                ),
                _mostrarCodigoBarras(productoProvider),
                _mostrarPrecioVenta(),
                SizedBox(
                  height: 15,
                ),
                (prodData == null)
                    ? _mostrarCategoriaEstatica()
                    : _mostrarCategoria(productoProvider),

                _mostrarBoton(productoProvider),
                // _containerPrueba(listaCategorias),
              ],
            ),
          ),
        ),
      ),
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
      if (foto != null) {
        return Image.file(
          foto,
          fit: BoxFit.cover,
          height: 300.0,
        );
      }
      return Image.asset('assets/no-image.png');
    }
  }

  _mostrarNombre() {
    return TextFormField(
      initialValue: producto.proNombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Nombre del Producto',
      ),
      onSaved: (value) => producto.proNombre = value,
    );
  }

  _mostrarCodigoBarras(ProductosProvider productosProvider) {
    // return TextFormField(
    //   initialValue: producto.proCodigoBarras,
    //   // initialValue: prov.codigoBarras,
    //   // textCapitalization: TextCapitalization.sentences,
    //   decoration: InputDecoration(
    //     labelText: 'Codigo de Barras',
    //   ),
    //   onSaved: (value) => producto.proCodigoBarras = value,
    // );
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        title: (producto.proCodigoBarras != null)
            ? Text(producto.proCodigoBarras)
            : Text('No código'),
        trailing: RaisedButton.icon(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          icon: Icon(Icons.local_bar),
          onPressed: () => _escanearCodigo(context, productosProvider),
          label: Text('Escanear'),
        ),
      ),
    );
  }

  _escanearCodigo(
      BuildContext context, ProductosProvider productosProvider) async {
    dynamic futureString = '';
    try {
      futureString = await BarcodeScanner.scan();
    } catch (e) {
      futureString = e.toString();
    }

    if (Utils.validador(futureString)) {
      //
      // productosProvider.codigoBarras = futureString;
      producto.proCodigoBarras = futureString;
      setState(() {});
    }

    print('Producto: ' + producto.proCodigoBarras);
    // setState(() {});
    //TODO Configurar la lógica de una venta
  }

  _mostrarCategoriaEstatica() {
    return TextFormField(
      initialValue: (producto.tblCategoriumCatId == null)
          ? ''
          : producto.tblCategoriumCatId.toString(),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Categoria',
      ),
      onSaved: (value) => producto.tblCategoriumCatId = int.parse(value),
    );
  }

  _mostrarCategoria(ProductosProvider productosProvider) {
    return FutureBuilder(
      future: productosProvider.listaCategoriasDrop(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: Text('Sin Informacion'),
          );
        }
        List<dynamic> lista = snapshot.data[0];
        print('listasnapshot: ' + lista.toString());
        return Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: new DropdownButton(
            hint: Text('Indique la categoria del Producto'),
            dropdownColor: Colors.blue[30],
            // elevation: 5,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 40.0,
            isExpanded: true,
            value: auxString,
            underline: SizedBox(),
            onChanged: (value) {
              setState(() {
                print('setstate ' + value.toString());
                auxString = value['catNombre'].toString();
                auxIdCat = int.parse(value['catId']);
              });
            },
            items: lista.map((value) {
              return DropdownMenuItem(
                // value: value,
                // child: Text(value['catNombre']),
                value: value['catId'],
                child: Text(value['catNombre']),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  _mostrarPrecioVenta() {
    return TextFormField(
      initialValue: (producto.proPrecioVenta == null)
          ? ''
          : producto.proPrecioVenta.toString(),
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Precio de Venta',
      ),
      onSaved: (value) => producto.proPrecioVenta = double.parse(value),
    );
  }

  _mostrarBoton(ProductosProvider productosProvider) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      icon: Icon(Icons.save),
      label: Text(_textoBoton),
      onPressed: (_estaGuardando) ? null : () => _submit(productosProvider),
      // onPressed: (_estaGuardando) ? null : _submit,
    );
  }

  void _submit(ProductosProvider productosProvider) async {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
    setState(() {
      _textoBoton = 'Espere por fa :v';
      _estaGuardando = true;
    });

    if (foto != null) {
      // producto.proFoto = await productosBloc.subirFoto(foto);
      producto.proFoto = await productosProvider.subirImagen(foto);
      // print("Secure link foto: " + producto.proFoto);
    }

    // print("Producto id " + producto.proId.toString());
    if (producto.proId == null) {
      final productoUpdate = new ProductoModelUpdate();
      productoUpdate.proId = 0;
      productoUpdate.proCodigoBarras = producto.proCodigoBarras;
      productoUpdate.proFoto = producto.proFoto;
      productoUpdate.proNombre = producto.proNombre;
      productoUpdate.proPrecioVenta = producto.proPrecioVenta;
      productoUpdate.tblCategoriumCatId = producto.tblCategoriumCatId;
      productoUpdate.proEstado = true;
      productosProvider.agregarProducto(productoUpdate);
    } else {
      final productoUpdate = new ProductoModelUpdate();
      productoUpdate.proId = producto.proId;
      productoUpdate.proCodigoBarras = producto.proCodigoBarras;
      productoUpdate.proFoto = producto.proFoto;
      productoUpdate.proNombre = producto.proNombre;
      productoUpdate.tblCategoriumCatId = producto.tblCategoriumCatId;
      productoUpdate.proEstado = true;
      print('vamos a editar');
      productosProvider.editarProducto(productoUpdate);
    }

    setState(() {
      _textoBoton = 'Guardar';
      _estaGuardando = false;
    });
    // mostrarSnackBar(context, 'Registro Guardado...');
    Navigator.pop(context);
  }

  _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async {
    // foto = await ImagePicker.pickImage(source: origen);
    final aux = await picker.getImage(source: origen);
    if (aux != null) {
      foto = File(aux.path);
    }
    setState(() {
      if (foto != null) {
        producto.proFoto = null;
      } else {
        print("Ninguna imagen seleccionada en _procesarImagen()");
      }
    });
  }

  // _containerPrueba(List<String> listaPrueba) {
  //   return Container(
  //     child: Text(listaPrueba.toString()),
  //   );
  // }
}
