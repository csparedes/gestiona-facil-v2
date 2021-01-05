import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestionafacil_v2/src/provider/productos_provider.dart';
import 'package:provider/provider.dart';
// import 'package:gestionafacil_v2/src/provider/google_sign_in_provider.dart';
// import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductosProvider()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Hola ' + user.displayName),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                // final provider =
                //     Provider.of<GoogleSignInProvider>(context, listen: false);
                // provider.logout();
                Navigator.pushReplacementNamed(context, 'login');
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                _catalogoProductos(context),
                _inventario(context),
                _ventasRealizadas(context),
                _comprasRealizadas(context),
                _caducados(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _catalogoProductos(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'productos');
        print('Productos');
      },
      child: Container(
        height: size.height * 0.20,
        // color: Colors.blue,
        child: Table(
          children: [
            TableRow(
              children: [
                // _crearIcono(),
                ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5.0,
                      sigmaY: 5.0,
                    ),
                    child: Container(
                      height: size.height * 0.15,
                      width: size.width * 0.45,
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(62, 66, 107, 0.7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Productos',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5.0,
                      sigmaY: 5.0,
                    ),
                    child: Container(
                      height: size.height * 0.15,
                      width: size.width * 0.45,
                      margin: EdgeInsets.all(15),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [Text('Inventario')],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _inventario(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'inventario');
        print('Inventario');
      },
      child: Container(
        height: size.height * 0.20,
        // color: Colors.blue,
        child: Table(
          children: [
            TableRow(
              children: [
                // _crearIcono(),
                ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5.0,
                      sigmaY: 5.0,
                    ),
                    child: Container(
                      height: size.height * 0.15,
                      width: size.width * 0.45,
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(62, 66, 107, 0.7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Inventario',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5.0,
                      sigmaY: 5.0,
                    ),
                    child: Container(
                      height: size.height * 0.15,
                      width: size.width * 0.45,
                      margin: EdgeInsets.all(15),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [Text('Inventario')],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _ventasRealizadas(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'ventas');
        print('Ventas');
      },
      child: Container(
        height: size.height * 0.20,
        // color: Colors.blue,
        child: Table(
          children: [
            TableRow(
              children: [
                // _crearIcono(),
                ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5.0,
                      sigmaY: 5.0,
                    ),
                    child: Container(
                      height: size.height * 0.15,
                      width: size.width * 0.45,
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(62, 66, 107, 0.7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Ventas',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5.0,
                      sigmaY: 5.0,
                    ),
                    child: Container(
                      height: size.height * 0.15,
                      width: size.width * 0.45,
                      margin: EdgeInsets.all(15),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [Text('Ventas')],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _comprasRealizadas(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'compras');
        print('compras');
      },
      child: Container(
        height: size.height * 0.20,
        // color: Colors.blue,
        child: Table(
          children: [
            TableRow(
              children: [
                // _crearIcono(),
                ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5.0,
                      sigmaY: 5.0,
                    ),
                    child: Container(
                      height: size.height * 0.15,
                      width: size.width * 0.45,
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(62, 66, 107, 0.7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Compras',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5.0,
                      sigmaY: 5.0,
                    ),
                    child: Container(
                      height: size.height * 0.15,
                      width: size.width * 0.45,
                      margin: EdgeInsets.all(15),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [Text('Compras')],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _caducados(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'caducados');
        print('caducados');
      },
      child: Container(
        height: size.height * 0.20,
        // color: Colors.blue,
        child: Table(
          children: [
            TableRow(
              children: [
                // _crearIcono(),
                ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5.0,
                      sigmaY: 5.0,
                    ),
                    child: Container(
                      height: size.height * 0.15,
                      width: size.width * 0.45,
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(62, 66, 107, 0.7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Productos',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5.0,
                      sigmaY: 5.0,
                    ),
                    child: Container(
                      height: size.height * 0.15,
                      width: size.width * 0.45,
                      margin: EdgeInsets.all(15),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [Text('Caducados')],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
