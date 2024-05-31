import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapboxMapController? mapController;

  final List<Map<String, dynamic>> locations = [
    {
      'title': 'MOD00647',
      "id": "1",
      'lat': 40.663230228015024,
      'lon': -74.21905805396766,
      'color': 'purple'
    },
    {
      'title': 'MOD00640',
      "id": "2",
      'lat': 40.64689059643284,
      'lon': -74.21452471845336,
      'color': 'purple'
    },
    {
      'title': 'MOD00642',
      "id": "3",
      'lat': 40.65378622504938,
      'lon': -74.18312423009269,
      'color': 'purple'
    },
    {
      'title': 'MOD00641',
      "id": "4",
      'lat': 40.66758328986866,
      'lon': -74.21969326518372,
      'color': 'purple'
    },
    {
      'title': 'MOD00646',
      "id": "5",
      'lat': 40.6595356872148,
      'lon': -74.19994720310858,
      'color': 'yellow'
    },
    {
      'title': 'MOD00638',
      "id": "6",
      'lat': 40.64706470283402,
      'lon': -74.21178765452444,
      'color': 'purple'
    },
    {
      'title': 'MOD00648',
      "id": "7",
      'lat': 40.64668781589756,
      'lon': -74.21368178580045,
      'color': 'purple'
    }
  ];

  void addmarkers() {
    for (var i in locations) {
      mapController?.addSymbol(
        SymbolOptions(
          geometry: LatLng(i['lat'], i['lon']),
          iconImage: 'marker',
          iconSize: 3,
        ),
      );
    }
  }

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    addmarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: MapboxMap(
        accessToken:
            'pk.eyJ1IjoidmlqYXlzb3VyaSIsImEiOiJjbHdwazJkaGExbXo2MmludmVmaWU2eTNiIn0._NaJ7fkzcjli1uPaVAoxjQ',
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(40.66576, -74.21225),
          zoom: 12.0,
        ),
      ),
    );
  }
}
