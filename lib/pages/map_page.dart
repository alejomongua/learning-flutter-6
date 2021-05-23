import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_reader/models/scan_model.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapType _mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final ScanModel? scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;
    Completer<GoogleMapController> _controller = Completer();

    final LatLng? _scanLatLng = scan!.getLatLon();

    final LatLng latLng =
        _scanLatLng == null ? LatLng(4.6736, -74.0819) : _scanLatLng;

    final CameraPosition _initialPoint = CameraPosition(
      target: latLng,
      zoom: 17,
      tilt: 50,
    );

    final Set<Marker> markers = Set<Marker>();

    markers.add(
      Marker(
        markerId: MarkerId('geo-location'),
        position: latLng,
      ),
    );

    print(scan.valor);

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller
                  .animateCamera(CameraUpdate.newCameraPosition(_initialPoint));
            },
          )
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        markers: markers,
        mapType: _mapType,
        initialCameraPosition: _initialPoint,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers),
        onPressed: () {
          setState(() {
            if (_mapType == MapType.normal) {
              _mapType = MapType.satellite;
            } else {
              _mapType = MapType.normal;
            }
          });
        },
      ),
    );
  }
}
