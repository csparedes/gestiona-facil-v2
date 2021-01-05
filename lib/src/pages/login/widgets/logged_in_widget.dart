import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestionafacil_v2/src/provider/google_sign_in_provider.dart';
import 'package:provider/provider.dart';

class LoggedInWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Container(
      alignment: Alignment.center,
      color: Colors.blueGrey.shade900,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Loggeo Exitoso',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8),
          CircleAvatar(
            maxRadius: 25,
            backgroundImage: NetworkImage(user.photoURL),
          ),
          SizedBox(height: 8),
          Text(
            'Usuario: ' + user.displayName,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            'Email: ' + user.email,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.logout();
                },
                child: Text('Logout'),
              ),
              SizedBox(
                width: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'home');
                },
                child: Text('Iniciar App'),
              )
            ],
          ),
        ],
      ),
    );
  }

  // Widget _pantalla_login(BuildContext context) {
  //   final user = FirebaseAuth.instance.currentUser;
  //   return Container(
  //     alignment: Alignment.center,
  //     color: Colors.blueGrey.shade900,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Text(
  //           'Logged In',
  //           style: TextStyle(color: Colors.white),
  //         ),
  //         SizedBox(height: 8),
  //         CircleAvatar(
  //           maxRadius: 25,
  //           backgroundImage: NetworkImage(user.photoURL),
  //         ),
  //         SizedBox(height: 8),
  //         Text(
  //           'Name: ' + user.displayName,
  //           style: TextStyle(color: Colors.white),
  //         ),
  //         SizedBox(height: 8),
  //         Text(
  //           'Email: ' + user.email,
  //           style: TextStyle(color: Colors.white),
  //         ),
  //         SizedBox(height: 8),
  //         ElevatedButton(
  //           onPressed: () {
  //             final provider =
  //                 Provider.of<GoogleSignInProvider>(context, listen: false);
  //             provider.logout();
  //           },
  //           child: Text('Logout'),
  //         )
  //       ],
  //     ),
  //   );
  // }
}
