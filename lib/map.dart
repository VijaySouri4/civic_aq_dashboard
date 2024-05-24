import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:aq_dashboard/SensorDetailsPage.dart';

class DisplayMap extends StatefulWidget {
  const DisplayMap({super.key});

  @override
  State<DisplayMap> createState() => _DisplayMapState();
}

class _DisplayMapState extends State<DisplayMap> {
  static List<Map<String, dynamic>> locations = [
    {
      'title': 'MOD00647',
      "id": "1",
      'lat': 40.663230228015024,
      'lon': -74.21905805396766
    },
    {
      'title': 'MOD00640',
      "id": "2",
      'lat': 40.64689059643284,
      'lon': -74.21452471845336
    },
    {
      'title': 'MOD00642',
      "id": "3",
      'lat': 40.65378622504938,
      'lon': -74.18312423009269
    },
    {
      'title': 'MOD00641',
      "id": "4",
      'lat': 40.66758328986866,
      'lon': -74.21969326518372
    },
    {
      'title': 'MOD00646',
      "id": "5",
      'lat': 40.6595356872148,
      'lon': -74.19994720310858
    },
    {
      'title': 'MOD00638',
      "id": "6",
      'lat': 40.64706470283402,
      'lon': -74.21178765452444
    },
    {
      'title': 'MOD00648',
      "id": "7",
      'lat': 40.64668781589756,
      'lon': -74.21368178580045
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        // onMapCreated: _onMapCreated,
        initialCameraPosition:
            CameraPosition(target: LatLng(40.66576, -74.21225), zoom: 12),
        markers: Set.from(Iterable.generate(locations.length, (index) {
          return Marker(
              markerId: MarkerId(locations[index]['id']),
              position: LatLng(
                locations[index]['lat'],
                locations[index]['lon'],
              ),
              infoWindow: InfoWindow(title: locations[index]["title"]),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SensorDetailsPage(
                          sensorName: locations[index]["title"])),
                );
              });
        })),
      ),
    );
  }
}
