import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gestionafacil_v2/src/provider/caducados_provider.dart';

class CaducadosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final caducados = Provider.of<CaducadosProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Productos'),
        actions: [
          IconButton(
            icon: Icon(Icons.find_in_page),
            onPressed: () {},
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text('Caducados Page'),
            Text(caducados.caducados),
          ],
        ),
      ),
    );
  }
}
