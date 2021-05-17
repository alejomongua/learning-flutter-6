import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/addresses_page.dart';

import 'package:qr_reader/pages/maps_page.dart';
import 'package:qr_reader/providers/ui_provider.dart';

class HomePage extends StatelessWidget {
  final _appBar = AppBar(
    title: Center(
      child: Text('Historial'),
    ),
    actions: [
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {},
      )
    ],
  );

  final _scanButton = FloatingActionButton(
    onPressed: () {},
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
    print(uiProvider.selectedMenuOpt);

    return Scaffold(
      appBar: _appBar,
      body: _HomePageBody(),
      bottomNavigationBar: _bottomNavigationBar(uiProvider),
      floatingActionButton: _scanButton,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentPage = uiProvider.selectedMenuOpt;

    switch (currentPage) {
      case 1:
        return AddressesPage();
      default:
        return MapsPage();
    }
  }
}
