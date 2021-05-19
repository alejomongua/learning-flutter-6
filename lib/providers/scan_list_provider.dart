import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:qr_reader/models/scan_model.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];

  String tipoSeleccionado = 'http';

  newScan(String valor) async {
    final scan = ScanModel(valor: valor);

    await DBProvider.db.insertScan(scan);

    if (tipoSeleccionado != scan.tipo) return;

    scans.add(scan);
    notifyListeners();
  }

  loadScans({String? tipo}) async {
    List newScans = await DBProvider.db.listScanCodes(tipo: tipo);
    scans = [...newScans];
    notifyListeners();
  }

  deleteAllScans({int? id}) async {
    await DBProvider.db.deleteScan(id: id);
    loadScans(tipo: tipoSeleccionado);
  }
}
