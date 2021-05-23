import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL(BuildContext context, ScanModel scan) async {
  if (scan.tipo == 'website') {
    if (!await canLaunch(scan.valor)) {
      throw '${scan.valor} no es una url válida';
    }

    await launch(scan.valor);
    return;
  }

  // else geo
  Navigator.pushNamed(
    context,
    'mapa',
    arguments: scan,
  );
}
