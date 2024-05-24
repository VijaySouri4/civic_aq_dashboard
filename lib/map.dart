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

  BitmapDescriptor? _greenMarker;
  BitmapDescriptor? _yellowMarker;
  BitmapDescriptor? _purpleMarker;

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  Future<void> _loadMarkers() async {
    _greenMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48, 48)),
      'assets/green_sensor.png',
    );
    _yellowMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48, 48)),
      'assets/yellow_sensor.png',
    );
    _purpleMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48, 48)),
      'assets/purple_sensor.png',
    );
    setState(() {});
  }

  BitmapDescriptor _getMarkerColor(String color) {
    switch (color) {
      case 'green':
        return _greenMarker!;
      case 'yellow':
        return _yellowMarker!;
      case 'purple':
        return _purpleMarker!;
      default:
        return BitmapDescriptor.defaultMarker;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: LatLng(40.66576, -74.21225), zoom: 12),
        markers: Set.from(Iterable.generate(locations.length, (index) {
          final location = locations[index];
          return Marker(
            markerId: MarkerId(location['id']),
            position: LatLng(location['lat'], location['lon']),
            icon: _getMarkerColor(location['color']),
            infoWindow: InfoWindow(title: location["title"]),
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SensorDetailsPage(sensorName: location["title"])),
              );
            },
          );
        })),
      ),
    );
  }
}
