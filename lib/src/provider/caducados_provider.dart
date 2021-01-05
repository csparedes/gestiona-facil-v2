import 'package:flutter/material.dart';

class CaducadosProvider with ChangeNotifier {
  String _caducados = 'Caducados';

  get caducados {
    return _caducados;
  }

  set caducados(String caducados) {
    this._caducados = caducados;
    notifyListeners();
  }
}
