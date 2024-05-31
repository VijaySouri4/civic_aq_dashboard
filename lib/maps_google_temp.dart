import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'summaryTable.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? mapController;
  final LatLng _center = const LatLng(40.66576, -74.21225);

  final List<Map<String, dynamic>> locations = [
    {
      'title': 'Farley Towers', //'MOD00647',
      "id": "1",
      'lat': 40.663230228015024,
      'lon': -74.21905805396766,
      'color': 'purple'
    },
    {
      'title': 'Mravlag, Building L', //'MOD00640',
      "id": "2",
      'lat': 40.64689059643284,
      'lon': -74.21452471845336,
      'color': 'purple'
    },
    {
      'title': 'E-Port Center', //'MOD00642',
      "id": "3",
      'lat': 40.65378622504938,
      'lon': -74.18312423009269,
      'color': 'purple'
    },
    {
      'title': 'Kennedy Arms', //'MOD00641',
      "id": "4",
      'lat': 40.66758328986866,
      'lon': -74.21969326518372,
      'color': 'purple'
    },
    {
      'title': 'Ford Leonard', //'MOD00646',
      "id": "5",
      'lat': 40.6595356872148,
      'lon': -74.19994720310858,
      'color': 'yellow'
    },
    {
      'title': 'Marvlag, Building K', //'MOD00638',
      "id": "6",
      'lat': 40.64706470283402,
      'lon': -74.21178765452444,
      'color': 'purple'
    },
    {
      'title': 'Marvalag, Building B', //'MOD00648',
      "id": "7",
      'lat': 40.64668781589756,
      'lon': -74.21368178580045,
      'color': 'purple'
    }
  ];

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              child: Container(
                color: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 12.0,
                    ),
                    markers: _createMarkers(),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              child: Summarytable(), // Using the HomePage widget here
            ),
          ),
        ],
      ),
    );
  }

  Set<Marker> _createMarkers() {
    return locations.map((location) {
      return Marker(
        markerId: MarkerId(location['id']),
        position: LatLng(location['lat'], location['lon']),
        infoWindow: InfoWindow(
          title: location['title'],
        ),
      );
    }).toSet();
  }
}
