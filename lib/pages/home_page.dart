import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:provider/provider.dart';

import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/widgets/item_builder_widget.dart';

class HomePage extends StatelessWidget {
  _scanButton(context) => FloatingActionButton(
        onPressed: () async {
          String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3D90F0',
            'cancelButtonText',
            false,
            ScanMode.QR,
          );

          print(barcodeScanRes);
          final scanListProvider = Provider.of<ScanListProvider>(
            context,
            listen: false,
          );

          scanListProvider.newScan(barcodeScanRes);
          Navigator.popAndPushNamed(context, 'home');
        },
        child: Icon(Icons.qr_code),
      );

  _bottomNavigationBar(UiProvider uiProvider) => BottomNavigationBar(
        currentIndex: uiProvider.selectedMenuOpt,
        onTap: (int selected) {
          uiProvider.selectedMenuOpt = selected;
        },
        items: [
          BottomNavigationBarItem(
            label: 'Mapa',
            icon: Icon(Icons.map),
          ),
          BottomNavigationBarItem(
            label: 'Direcciones',
            icon: Icon(Icons.location_city),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final scanListProvider = Provider.of<ScanListProvider>(
      context,
      listen: false,
    );
    print(uiProvider.selectedMenuOpt);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Historial'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              scanListProvider.deleteScans();
            },
          )
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: _bottomNavigationBar(uiProvider),
      floatingActionButton: _scanButton(context),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentPage = uiProvider.selectedMenuOpt;
    final scanListProvider = Provider.of<ScanListProvider>(
      context,
      listen: false,
    );

    switch (currentPage) {
      case 1:
        scanListProvider.loadScans(tipo: 'website');
        return ItemBuilderWidget(tipo: 'website');
      default:
        scanListProvider.loadScans(tipo: 'geo');
        return ItemBuilderWidget(tipo: 'geo');
    }
  }
}
