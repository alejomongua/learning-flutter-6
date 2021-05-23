import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ItemBuilderWidget extends StatelessWidget {
  ItemBuilderWidget({required this.tipo});
  final String tipo;

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;
    final IconData icon = tipo == 'website' ? Icons.map : Icons.alternate_email;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, i) => Dismissible(
        key: UniqueKey(),
        onDismissed: (_) {
          print('dismissed ${scans[i].id}');
          Provider.of<ScanListProvider>(
            context,
            listen: false,
          ).deleteScans(id: scans[i].id);
        },
        child: ListTile(
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
            launchURL(context, scans[i]);
          },
        ),
      ),
    );
  }
}
