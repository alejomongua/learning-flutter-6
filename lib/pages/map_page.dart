import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_reader/models/scan_model.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    final ScanModel? scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;
    Completer<GoogleMapController> _controller = Completer();

    final CameraPosition _initialPoint = CameraPosition(
      target: LatLng(4.6736, -74.0819),
      zoom: 17,
    );

    print(scan!.valor);

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initialPoint,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
