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
import 'dart:ui' as ui;
import 'dart:typed_data';

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
  Set<Marker> markers = Set<Marker>();

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

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  void _loadMarkers() async {
    final Set<Marker> loadedMarkers = await _createMarkers();
    setState(() {
      markers = loadedMarkers;
    });
  }

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
        return Positioned(
          left: screenWidth / 2 - 100,
          top: screenHeight / 2 - 100,
          child: Material(
            child: Container(
              padding: EdgeInsets.all(20),
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Mravlag Manor 3',
                        style: TextStyle(
                          fontFamily: 'Work Sans',
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          _hidePopup();
                        },
                      ),
                    ],
                  ),
                  // SizedBox(height: 0.1),
                  Text(
                    'Last Updated 21:31',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: "Work Sans",
                      color: Colors.grey,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'AIR QUALITY MEASURES',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'AQI',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Work Sans',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 110,
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFF5D9913),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '30',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontFamily: 'Work Sans',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Good',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Work Sans",
                          color: Color(0xFF8E8C8C),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'PM 2.5',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Work Sans',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        "μg/m³",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'Work Sans',
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF8E8C8C),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFFCF0808),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '100',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontFamily: 'Work Sans',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Unhealty',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Work Sans",
                          color: Color(0xFF8E8C8C),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          // Implement your onPressed functionality here
                        },
                        child: Text(
                          'View Device History',
                          style: TextStyle(
                            color: Color(0xFF9795B5),
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFF9795B5),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Work Sans",
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
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
                              LatLng position = LatLng(locations[index]['lat'],
                                  locations[index]['lon']);
                              _onMarkerTapped(locations[index]['id'], position);
                              _moveCameraToLocation(locations[index]['lat'],
                                  locations[index]['lon']);
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
                          markers: markers,
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

  Future<BitmapDescriptor> createCustomMarkerIcon(
      Color color, String text) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color = color.withOpacity(0.9);
    final double radius = 20.0; // Adjust the radius as needed

    canvas.drawCircle(
      Offset(radius, radius),
      radius,
      paint,
    );

    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontFamily: "Work Sans",
          fontSize: 18.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        radius - textPainter.width / 2,
        radius - textPainter.height / 2,
      ),
    );

    final ui.Image image = await pictureRecorder.endRecording().toImage(
          (radius * 2).toInt(),
          (radius * 2).toInt(),
        );

    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List bytes = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(bytes);
  }

  Future<Set<Marker>> _createMarkers() async {
    final List<Future<Marker>> futureMarkers = locations.map((location) async {
      Color markerColor;
      switch (location['color']) {
        case 'green':
          markerColor = Colors.green;
          break;
        case 'yellow':
          markerColor = Colors.yellow;
          break;
        default:
          markerColor = Colors.blue; // Default color
      }
      final BitmapDescriptor markerIcon =
          await createCustomMarkerIcon(markerColor, "15");

      return Marker(
        markerId: MarkerId(location['id']),
        position: LatLng(location['lat'], location['lon']),
        // infoWindow: InfoWindow(
        //   title: location['title'],
        // ),
        icon: markerIcon,
        onTap: () {
          _onMarkerTapped(
              location['id'], LatLng(location['lat'], location['lon']));
        },
      );
    }).toList();

    return futureMarkers.isNotEmpty
        ? Set<Marker>.from(await Future.wait(futureMarkers))
        : Set<Marker>();
  }
}


// Stack(
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(8),
//                   margin: EdgeInsets.only(top: 10),
//                   color: Colors.white,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text('Sensor ID: $selectedSensorId'),
                      
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   right: 0,
//                   top: 0,
//                   child: IconButton(
//                     icon: Icon(Icons.close),
//                     onPressed: _hidePopup,
//                   ),
//                 ),
//               ],
//             ),