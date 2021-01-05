import 'package:flutter/material.dart';

class Rectangulo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.3,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.green,
      ),
    );
  }
}
