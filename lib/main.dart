import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gestionafacil_v2/src/provider/nueva_compra_provider.dart';
import 'package:provider/provider.dart';

import 'package:gestionafacil_v2/src/pages/compras/nueva_compra_page.dart';
import 'package:gestionafacil_v2/src/pages/productos/categoria/categoria_detalle_page.dart';
import 'package:gestionafacil_v2/src/pages/productos/widgets/producto_detalle.dart';
import 'package:gestionafacil_v2/src/pages/productos/categoria/categoria_page.dart';
import 'package:gestionafacil_v2/src/pages/caducados/caducados_page.dart';
import 'package:gestionafacil_v2/src/pages/compras/compras_page.dart';
import 'package:gestionafacil_v2/src/pages/home/home_page.dart';
import 'package:gestionafacil_v2/src/pages/inventario/inventario_page.dart';
import 'package:gestionafacil_v2/src/pages/login/login.dart';
import 'package:gestionafacil_v2/src/pages/productos/productos_page.dart';
import 'package:gestionafacil_v2/src/pages/ventas/nueva_venta_page.dart';
import 'package:gestionafacil_v2/src/pages/ventas/ventas_page.dart';

import 'package:gestionafacil_v2/src/provider/categorias_provider.dart';
import 'package:gestionafacil_v2/src/provider/nueva_venta_provider.dart';
import 'package:gestionafacil_v2/src/provider/caducados_provider.dart';
import 'package:gestionafacil_v2/src/provider/compras_provider.dart';
import 'package:gestionafacil_v2/src/provider/inventario_provider.dart';
import 'package:gestionafacil_v2/src/provider/productos_provider.dart';
import 'package:gestionafacil_v2/src/provider/ventas_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductosProvider()),
        ChangeNotifierProvider(create: (context) => InventarioProvider()),
        ChangeNotifierProvider(create: (context) => VentasProvider()),
        ChangeNotifierProvider(create: (context) => ComprasProvider()),
        ChangeNotifierProvider(create: (context) => CaducadosProvider()),
        ChangeNotifierProvider(create: (context) => NuevaVentaProvider()),
        ChangeNotifierProvider(create: (context) => NuevaCompraProvider()),
        ChangeNotifierProvider(create: (context) => CategoriaProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gestiona Facil App',
        initialRoute: 'login',
        routes: {
          'login': (_) => LoginPage(),
          'home': (_) => HomePage(),
          'productos': (_) => ProductosPage(),
          'inventario': (_) => InventarioPage(),
          'ventas': (_) => VentasPage(),
          'compras': (_) => ComprasPage(),
          'caducados': (_) => CaducadosPage(),
          'nuevaVenta': (_) => NuevaVentaPage(),
          'nuevaCompra': (_) => NuevaCompraPage(),
          'productoDetalle': (_) => ProductoDetallePage(),
          'categoria': (_) => CategoriaPage(),
          'categoriaDetalle': (_) => CategoriaDetallePage(),
        },
      ),
    );
  }
}
