// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'sensorDetailsWidget.dart';
// import 'summaryTable.dart';

// class MapPage extends StatefulWidget {
//   @override
//   _MapPageState createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   GoogleMapController? mapController;
//   final LatLng _center = const LatLng(40.66576, -74.21225);
//   String? selectedSensorId;
//   Offset? markerOffset;
//   Marker? _selectedMarker;
//   bool showPopup = false;

//   final List<Map<String, dynamic>> locations = [
//     {
//       'title': 'Farley Towers',
//       "id": 'MOD00647',
//       'lat': 40.663230228015024,
//       'lon': -74.21905805396766,
//       'color': 'green'
//     },
//     {
//       'title': 'Mravlag, Building L',
//       "id": 'MOD00640',
//       'lat': 40.64689059643284,
//       'lon': -74.21452471845336,
//       'color': 'green'
//     },
//     {
//       'title': 'E-Port Center',
//       "id": 'MOD00642',
//       'lat': 40.65378622504938,
//       'lon': -74.18312423009269,
//       'color': 'green'
//     },
//     {
//       'title': 'Kennedy Arms',
//       "id": 'MOD00641',
//       'lat': 40.66758328986866,
//       'lon': -74.21969326518372,
//       'color': 'green'
//     },
//     {
//       'title': 'Ford Leonard',
//       "id": 'MOD00646',
//       'lat': 40.6595356872148,
//       'lon': -74.19994720310858,
//       'color': 'green'
//     },
//     {
//       'title': 'Marvlag, Building K',
//       "id": 'MOD00638',
//       'lat': 40.64706470283402,
//       'lon': -74.21178765452444,
//       'color': 'green'
//     },
//     {
//       'title': 'Marvalag, Building B',
//       "id": 'MOD00648',
//       'lat': 40.64668781589756,
//       'lon': -74.21368178580045,
//       'color': 'green'
//     }
//   ];

//   void _onMapCreated(GoogleMapController controller) {
//     setState(() {
//       mapController = controller;
//     });
//   }

//   void _onMarkerTapped(String sensorId, LatLng position) {
//     setState(() {
//       selectedSensorId = sensorId;
//       showPopup = true;
//     });
//   }

//   void _moveCameraToLocation(double lat, double lon) {
//     mapController?.animateCamera(CameraUpdate.newLatLng(LatLng(lat, lon)));
//   }

//   void _showPopupOverMarker(MarkerId marker) {
//     if (marker != null) {
//       mapController?.showMarkerInfoWindow(marker);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: null,
//       body: Column(
//         children: [
//           Expanded(
//             flex: 1,
//             child: Row(
//               children: [
//                 Expanded(
//                   child: ListView.separated(
//                       separatorBuilder: (context, index) => Divider(),
//                       itemCount: locations.length,
//                       itemBuilder: (context, index) {
//                         return Container(
//                           padding: EdgeInsets.fromLTRB(20, 16, 20, 20),
//                           child: GestureDetector(
//                             onTap: () {
//                               LatLng position = LatLng(
//                               locations[index]['lat'], locations[index]['lon']);
//                           _onMarkerTapped(locations[index]['id'], position);
//                           _moveCameraToLocation(
//                               locations[index]['lat'], locations[index]['lon']);
//                           _showPopupOverMarker(
//                               MarkerId(locations[index]['id']));
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       locations[index]['title'],
//                                       style: const TextStyle(
//                                           fontSize: 16,
//                                           fontFamily: "Work Sans",
//                                           fontWeight: FontWeight.w400,
//                                           color: Colors.black),
//                                     ),
//                                     const SizedBox(height: 6.0),
//                                     Text(
//                                       'QuantAQ: ${locations[index]['id']}',
//                                       style: const TextStyle(
//                                         fontSize: 14.0,
//                                         fontWeight: FontWeight.w400,
//                                         fontFamily: "Work Sans",
//                                         color: Colors.grey,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(width: 80.0),
//                                 SizedBox(
//                                   width: 44.0,
//                                   height: 44.0,
//                                   child: Image.asset('gray_sensor_on.png'),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       }),
//                 ),
//                 Expanded(
//                   flex: 3,
//                   child: Container(
//                     color: Colors.grey,
//                     child: GoogleMap(
//                       onMapCreated: _onMapCreated,
//                       initialCameraPosition: CameraPosition(
//                         target: _center,
//                         zoom: 12.0,
//                       ),
//                       markers: _createMarkers(),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Set<Marker> _createMarkers() {
//     return locations.map((location) {
//       BitmapDescriptor markerIcon;
//       switch (location['color']) {
//         case 'green':
//           markerIcon =
//               BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
//           break;
//         case 'yellow':
//           markerIcon =
//               BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
//           break;
//         default:
//           markerIcon = BitmapDescriptor.defaultMarker;
//       }
//       return Marker(
//         markerId: MarkerId(location['id']),
//         position: LatLng(location['lat'], location['lon']),
//         infoWindow: InfoWindow(
//           title: location['title'],
//         ),
//         icon: markerIcon,
//         onTap: () {
//           _onMarkerTapped(
//               location['id'], LatLng(location['lat'], location['lon']));
//         },
//       );
//     }).toSet();
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? mapController;
  final LatLng _center = const LatLng(40.66576, -74.21225);
  String? selectedSensorId;
  LatLng? selectedPosition;
  OverlayEntry? popupOverlay;

  final List<Map<String, dynamic>> locations = [
    {
      'title': 'Farley Towers',
      "id": 'MOD00647',
      'lat': 40.663230228015024,
      'lon': -74.21905805396766,
      'color': 'green'
    },
    {
      'title': 'Mravlag, Building L',
      "id": 'MOD00640',
      'lat': 40.64689059643284,
      'lon': -74.21452471845336,
      'color': 'green'
    },
    {
      'title': 'E-Port Center',
      "id": 'MOD00642',
      'lat': 40.65378622504938,
      'lon': -74.18312423009269,
      'color': 'green'
    },
    {
      'title': 'Kennedy Arms',
      "id": 'MOD00641',
      'lat': 40.66758328986866,
      'lon': -74.21969326518372,
      'color': 'green'
    },
    {
      'title': 'Ford Leonard',
      "id": 'MOD00646',
      'lat': 40.6595356872148,
      'lon': -74.19994720310858,
      'color': 'green'
    },
    {
      'title': 'Marvlag, Building K',
      "id": 'MOD00638',
      'lat': 40.64706470283402,
      'lon': -74.21178765452444,
      'color': 'green'
    },
    {
      'title': 'Marvalag, Building B',
      "id": 'MOD00648',
      'lat': 40.64668781589756,
      'lon': -74.21368178580045,
      'color': 'green'
    }
  ];

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void _onMarkerTapped(String sensorId, LatLng position) {
    setState(() {
      selectedSensorId = sensorId;
      selectedPosition = position;
      _showPopup(context, position);
    });
  }

  void _moveCameraToLocation(double lat, double lon) {
    mapController?.animateCamera(CameraUpdate.newLatLng(LatLng(lat, lon)));
  }

  void _showPopup(BuildContext context, LatLng position) {
    if (popupOverlay != null) {
      popupOverlay?.remove();
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    popupOverlay = OverlayEntry(
      builder: (context) {
        // Assuming the marker is at the center of the screen
        return Positioned(
          left: screenWidth / 2 - 50,
          top: screenHeight / 2 - 100,
          child: Material(
            color: Colors.transparent,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.white,
                  child: Text('Sensor ID: $selectedSensorId'),
                ),
                CustomPaint(
                  painter: TrianglePainter(),
                ),
              ],
            ),
          ),
        );
      },
    );

    Overlay.of(context)?.insert(popupOverlay!);
  }

  void _hidePopup() {
    popupOverlay?.remove();
    popupOverlay = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: locations.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.fromLTRB(20, 16, 20, 20),
                          child: GestureDetector(
                            onTap: () {
                              LatLng position = LatLng(
                                  locations[index]['lat'], locations[index]['lon']);
                              _onMarkerTapped(locations[index]['id'], position);
                              _moveCameraToLocation(
                                  locations[index]['lat'], locations[index]['lon']);
                              _showPopup(context, position);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      locations[index]['title'],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: "Work Sans",
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(height: 6.0),
                                    Text(
                                      'QuantAQ: ${locations[index]['id']}',
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Work Sans",
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 80.0),
                                SizedBox(
                                  width: 44.0,
                                  height: 44.0,
                                  child: Image.asset('gray_sensor_on.png'),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.grey,
                    child: Stack(
                      children: [
                        GoogleMap(
                          onMapCreated: _onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target: _center,
                            zoom: 12.0,
                          ),
                          markers: _createMarkers(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Set<Marker> _createMarkers() {
    return locations.map((location) {
      BitmapDescriptor markerIcon;
      switch (location['color']) {
        case 'green':
          markerIcon =
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
          break;
        case 'yellow':
          markerIcon =
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
          break;
        default:
          markerIcon = BitmapDescriptor.defaultMarker;
      }
      return Marker(
        markerId: MarkerId(location['id']),
        position: LatLng(location['lat'], location['lon']),
        infoWindow: InfoWindow(
          title: location['title'],
        ),
        icon: markerIcon,
        onTap: () {
          _onMarkerTapped(
              location['id'], LatLng(location['lat'], location['lon']));
        },
      );
    }).toSet();
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

