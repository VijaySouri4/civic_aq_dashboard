import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'SensorDetailsPage.dart';
import 'home_page.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapboxMapController? mapController;
  String selectedSymbolTitle = "home";

  static List<Map<String, dynamic>> locations = [
    {
      'title': '1',
      "id": "1",
      'lat': 40.663230228015024,
      'lon': -74.21905805396766
    },
    {
      'title': '2',
      "id": "2",
      'lat': 40.64689059643284,
      'lon': -74.21452471845336
    },
    {
      'title': '3',
      "id": "3",
      'lat': 40.65378622504938,
      'lon': -74.18312423009269
    },
    {
      'title': '4',
      "id": "4",
      'lat': 40.66758328986866,
      'lon': -74.21969326518372
    },
    {
      'title': '5',
      "id": "5",
      'lat': 40.6595356872148,
      'lon': -74.19994720310858
    },
    {
      'title': '6',
      "id": "6",
      'lat': 40.64706470283402,
      'lon': -74.21178765452444
    },
    {
      'title': '7',
      "id": "7",
      'lat': 40.64668781589756,
      'lon': -74.21368178580045
    }
  ];

  void _addMarkers() {
    for (var location in locations) {
      mapController?.addSymbol(
        SymbolOptions(
            geometry: LatLng(location['lat'], location['lon']),
            iconImage: "marker-15",
            iconSize: 3,
            textField: location['title'],
            textOffset: Offset(0, 1.5),
            textSize: 21,
            textAnchor: "top",
            iconColor: "red"),
      );
    }
  }

  void _onSymbolTapped(Symbol symbol) {
    final String? title = symbol.options.textField;
    if (title != null) {
      setState(() {
        selectedSymbolTitle = title;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SensorDetailsPage(sensorName: title)),
      );
    }
  }

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    _addMarkers();
    mapController?.onSymbolTapped.add(_onSymbolTapped);
  }

  @override
  void dispose() {
    mapController?.onSymbolTapped.remove(_onSymbolTapped);
    mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                MapboxMap(
                  accessToken:
                      "pk.eyJ1IjoidmlqYXlzb3VyaSIsImEiOiJjbHdwazJkaGExbXo2MmludmVmaWU2eTNiIn0._NaJ7fkzcjli1uPaVAoxjQ",
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(40.66576, -74.21225),
                    zoom: 12.0,
                  ),
                  onStyleLoadedCallback: () {
                    _addMarkers();
                  },
                ),
                // Positioned(
                //   top: 20,
                //   right: 20,
                //   child: ElevatedButton(
                //     onPressed: () {
                //       setState(() {
                //         selectedSymbolTitle = "home";
                //       });
                //     },
                //     child: Text('Home'),
                //     style: ElevatedButton.styleFrom(
                //       fixedSize: Size(120, 60), // Adjust the size as needed
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.4,
              color: Colors.blueGrey[50], // Just for visual differentiation
              child:
                  HomePage()), //SensorDetailsPage(sensorName: selectedSymbolTitle)),
        ],
      ),
    );
  }
}
