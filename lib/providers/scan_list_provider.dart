import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:qr_reader/models/scan_model.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];

  newScan(String valor) async {
    final scan = ScanModel(valor: valor);

    await DBProvider.db.insertScan(scan);
  }

  loadScans({String? tipo}) async {
    List newScans = await DBProvider.db.listScanCodes(tipo: tipo);
    scans = [...newScans];
    notifyListeners();
  }

  deleteScans({int? id}) async {
    print(["eliminado", id]);
    await DBProvider.db.deleteScan(id: id);
  }
}
