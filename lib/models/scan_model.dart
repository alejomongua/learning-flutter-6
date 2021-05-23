import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));
String scanModelToJson(ScanModel data) => json.encode(data.toJson());

const REGEX_STRING = r"^geo:(-?\d*\.?\d*), ?(-?\d*\.?\d*)";

final geoRegex = RegExp(REGEX_STRING);

class ScanModel {
  ScanModel({
    required this.valor,
    this.id,
    this.tipo,
  }) {
    if (valor.startsWith('http')) {
      tipo = 'website';
    } else {
      tipo = 'geo';
    }
  }

  int? id;
  String? tipo;
  String valor;

  LatLng? getLatLon() {
    if (tipo == 'geo') return null;

    RegExpMatch? match = geoRegex.firstMatch(valor);

    if (match == null) return null;

    List<double> coordenadas =
        match.groups([1, 2]).map((str) => double.parse(str!)).toList();

    return LatLng(coordenadas[0], coordenadas[1]);
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
      };
}
