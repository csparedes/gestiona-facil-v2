import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:gestionafacil_v2/src/pages/login/widgets/logged_in_widget.dart';
import 'package:gestionafacil_v2/src/pages/login/widgets/background_painter.dart';
import 'package:gestionafacil_v2/src/pages/login/widgets/sign_up_widget.dart';
import 'package:gestionafacil_v2/src/provider/google_sign_in_provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            final provider = Provider.of<GoogleSignInProvider>(context);

            if (provider.isSigningIn) {
              return buildLoading(context);
            } else if (snapshot.hasData) {
              return LoggedInWidget();
            } else {
              return SignUpWidget();
            }
          },
        ),
      ),
    );
  }

  Widget buildLoading(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(painter: BackgroundPainter()),
        Center(child: CircularProgressIndicator())
      ],
    );
  }

  // Widget _fondo(BuildContext context) {
  //   final size = MediaQuery.of(context).size;
  //   final fondoMorado = Container(
  //     height: size.height * 0.6,
  //     width: double.infinity,
  //     decoration: BoxDecoration(
  //         gradient: LinearGradient(colors: [
  //       Color.fromRGBO(25, 128, 131, 1),
  //       Color.fromRGBO(25, 128, 131, 0.7),
  //     ])),
  //   );
  //   final circulo = Container(
  //     width: 100,
  //     height: 100,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(100),
  //       color: Color.fromRGBO(255, 255, 255, 0.05),
  //     ),
  //   );
  //   return Stack(
  //     children: [
  //       fondoMorado,
  //       Positioned(
  //         top: 90.0,
  //         left: 30.0,
  //         child: circulo,
  //       ),
  //       Positioned(
  //         top: -40.0,
  //         right: -30.0,
  //         child: circulo,
  //       ),
  //       Positioned(
  //         bottom: -50.0,
  //         right: -10.0,
  //         child: circulo,
  //       ),
  //       Positioned(
  //         top: 50.0,
  //         right: 30.0,
  //         child: circulo,
  //       ),
  //       Positioned(
  //         top: 120.0,
  //         left: 20.0,
  //         child: circulo,
  //       ),
  //       Container(
  //         padding: EdgeInsets.only(top: 80.0),
  //         child: Column(
  //           children: [
  //             Icon(
  //               Icons.store,
  //               color: Colors.white,
  //               size: 100,
  //             ),
  //             SizedBox(
  //               height: 10.0,
  //               width: double.infinity,
  //             ),
  //             Text(
  //               'Gestiona Facil',
  //               style: TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 25,
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _formulario(BuildContext context) {
  //   final size = MediaQuery.of(context).size;

  //   return SingleChildScrollView(
  //     child: Column(
  //       children: [
  //         SafeArea(
  //           child: Container(
  //             height: size.height * 0.05,
  //           ),
  //         ),
  //         Container(
  //           width: size.width * 0.85,
  //           decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(5),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.black26,
  //                   blurRadius: 3.0,
  //                   offset: Offset(0, 5),
  //                   spreadRadius: 3.0,
  //                 ),
  //               ]),
  //           child: Column(
  //             children: [
  //               SizedBox(
  //                 height: 50,
  //               ),
  //               Text(
  //                 'Ingreso a la App',
  //                 style: TextStyle(
  //                   fontSize: 20.0,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 50.0,
  //               ),
  //               _crearEmail(),
  //               SizedBox(
  //                 height: 30,
  //               ),
  //               _crearPassword(),
  //               SizedBox(
  //                 height: 30,
  //               ),
  //               _crearBoton(),
  //               SizedBox(
  //                 height: 30,
  //               ),
  //             ],
  //           ),
  //         ),
  //         Container(
  //           child: Text('Elaborado por: Cristian Paredes Sánchez'),
  //           padding: EdgeInsets.all(30),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // _crearEmail() {
  //   return Container(
  //     height: 500,
  //   );
  // }

  // _crearPassword() {
  //   return Container(
  //     height: 500,
  //   );
  // }

  // _crearBoton() {
  //   return Container(
  //     height: 500,
  //   );
  // }

}
