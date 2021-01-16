import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestionafacil_v2/src/models/kardex_ingreso_model.dart';
import 'package:gestionafacil_v2/src/provider/nueva_compra_provider.dart';
import 'package:gestionafacil_v2/src/validators/utils.dart';
import 'package:provider/provider.dart';
// import 'package:gestionafacil_v2/src/models/producto_model.dart';
// import 'package:gestionafacil_v2/src/provider/nueva_compra_provider.dart';
// import 'package:gestionafacil_v2/src/provider/productos_provider.dart';
// // import 'package:path/path.dart';
// import 'package:provider/provider.dart';
// import 'package:gestionafacil_v2/src/provider/productos_provider.dart';
// import 'package:provider/provider.dart';

class ModalCompraWidget extends StatefulWidget {
  final List<KardexIngresoModel> listaKardex;
  final int i;
  ModalCompraWidget(this.listaKardex, this.i);

  @override
  _ModalCompraWidgetState createState() => _ModalCompraWidgetState();
}

class _ModalCompraWidgetState extends State<ModalCompraWidget> {
  final formKey = GlobalKey<FormState>();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  int cantidadAux;

  double precioAux;

  @override
  Widget build(BuildContext context) {
    final kardexProvider = Provider.of<NuevaCompraProvider>(context);
    return AlertDialog(
      title: Text(widget.listaKardex[widget.i].tblProductoIngreso.proNombre),
      content: Container(
        // height: MediaQuery.of(context).size.height * 0.6,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _cantidad(widget.listaKardex[widget.i]),
              _precioUnitario(widget.listaKardex[widget.i]),
              _seleccionarFecha(widget.listaKardex[widget.i]),
            ],
          ),
        ),
      ),
      actions: [
        FlatButton(
          child: Text('Ok'),
          onPressed: () {
            _submit(kardexProvider);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  _cantidad(KardexIngresoModel kardexIngreso) {
    return Container(
      child: Container(
        child: TextFormField(
          initialValue: (kardexIngreso.kiCantidad == 0)
              ? '0'
              : kardexIngreso.kiCantidad.toString(),
          decoration: InputDecoration(labelText: 'Cantidad'),
          keyboardType: TextInputType.number,
          onChanged: (value) => cantidadAux = int.parse(value),
        ),
      ),
    );
  }

  _precioUnitario(KardexIngresoModel kardexIngreso) {
    return Container(
      child: TextFormField(
        initialValue: (kardexIngreso.tblProductoIngreso.proPrecioVenta == null)
            ? ''
            : kardexIngreso.tblProductoIngreso.proPrecioVenta.toString(),
        decoration: InputDecoration(
          labelText: 'Precio Unitario',
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) => precioAux = double.parse(value),
      ),
    );
  }

  _seleccionarFecha(KardexIngresoModel kardexIngreso) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(kardexIngreso.kiFechaCaducidad == null
              ? 'Sin fecha'
              : kardexIngreso.kiFechaCaducidad),
          RaisedButton.icon(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            icon: Icon(Icons.calendar_today),
            label: Text('Caduca: '),
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2019),
                lastDate: DateTime(2026),
                confirmText: 'Aceptar',
                cancelText: 'Cancelar',
                helpText: 'Calendario',
                builder: (BuildContext context, Widget child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      colorScheme: ColorScheme.light(
                        primary: Colors.white,
                        // onPrimary: Theme.of(context).primaryColor,
                        onPrimary: Colors.blue,
                        surface: Colors.white,
                        onSurface: Colors.white,
                      ),
                      dialogBackgroundColor: Colors.blue,
                      // dialogBackgroundColor: Colors.white,
                    ),
                    child: child,
                  );
                },
              ).then((value) {
                kardexIngreso.kiFechaCaducidad = Utils.transformarFecha(value);
                setState(() {});
                return;
              });
            },
          ),
        ],
      ),
    );
  }

  _submit(NuevaCompraProvider kardexProvider) {
    kardexProvider.editarIngreso(
        widget.listaKardex, widget.i, cantidadAux, precioAux);
  }
}
