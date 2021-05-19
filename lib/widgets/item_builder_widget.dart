import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';

class ItemBuilderWidget extends StatelessWidget {
  final IconData icon;
  ItemBuilderWidget({required this.icon});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, i) => ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).accentColor,
        ),
        title: Text(scans[i].valor),
        subtitle: Text('ID: ${scans[i].id}'),
        trailing: Icon(
          Icons.arrow_right,
          color: Theme.of(context).accentColor,
        ),
        onTap: () {
          print(scans[i].valor);
        },
      ),
    );
  }
}
