import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'apiCall.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? mapController;
  final LatLng _center = const LatLng(40.659854, -74.209016);
  String? selectedSensorId;
  LatLng? selectedPosition;
  OverlayEntry? popupOverlay;
  Set<Marker> markers = Set<Marker>();
  List<Map<String, dynamic>> locations_new = [];
  

  final Map<String, String> idToTitle = {
  'MOD-00647': 'Farley Towers',
  'MOD-00640': 'Mravlag, Building L',
  'MOD-00642': 'E-Port Center',
  'MOD-00641': 'Kennedy Arms',
  'MOD-00646': 'Ford Leonard',
  'MOD-00638': 'Marvlag, Building K',
  'MOD-00648': 'Marvalag, Building B'
};

  Future<List<Map<String, dynamic>>> _fetchSensorData() async {
  try {
    final response = await http.get(Uri.parse('https://civic-aq-dashboard.com/api/latest')); 

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      List<Map<String, dynamic>> parsedData = data.map((item) {
        final sensorData = item['data'];
        final localTimestamp = sensorData[2];
        
        final pm10 = sensorData[9] != null ? double.parse(sensorData[9]) : 0.0;
        final pm25 = sensorData[10] != null ? double.parse(sensorData[10]) : 0.0;
        final o3 = sensorData[7] != null ? double.parse(sensorData[7]) : 0.0;
        final aqi = [o3, pm10].reduce((a, b) => a > b ? a : b);

        final sensor_id = sensorData[3] != null ? sensorData[3] : "#000";
        final lat = sensorData[13] != null ? double.parse(sensorData[13]) : 0.0;
        final lon = sensorData[14] != null ? double.parse(sensorData[14]) : 0.0;
        final title = idToTitle[sensor_id] ?? "No Title";

        return {
          'timestamp': localTimestamp,
          'aqi': aqi,
          'status': 'active',
          'pm 2.5': pm25,
          'id': sensor_id,
          'lat': lat,
          'lon': lon,
          'title': title,
          'color':'green'
        };
      }).toList();

      return parsedData;
    } else {
      print('Failed to load data: ${response.body}');
      return [];
    }
  } catch (e) {
    print('Error fetching data: $e');
    return [];
  }
}


  @override
  initState()  {
    super.initState();
    _loadMarkers();
  }

  Future<Set<Marker>> _createMarkers(List<Map<String, dynamic>> data) async {
    final List<Future<Marker>> futureMarkers = data.map((location) async {
      Color markerColor;
      final double aqi = location['aqi'] as double;
    if (aqi >= 0 && aqi <= 40) {
      markerColor = Color(0xFF5D9913);
    } else if (aqi >= 41 && aqi <= 80) {
      markerColor = Color(0xFFE8B207);
    } 
    else if (aqi >= 81 && aqi <= 120) {
      markerColor = Color(0xFFD96607);
    } 
    else {
      markerColor = Colors.red;
    }
      final BitmapDescriptor markerIcon = await createCustomMarkerIcon(markerColor, aqi.floor().toString());

      return Marker(
        markerId: MarkerId(location['id']),
        position: LatLng(location['lat'], location['lon']),
        icon: markerIcon,
        onTap: () {
          _onMarkerTapped(location['id'], LatLng(location['lat'], location['lon']), location['title'], location['timestamp'], location['aqi'], location['pm 2.5']);
        },
      );
    }).toList();

    return futureMarkers.isNotEmpty
        ? Set<Marker>.from(await Future.wait(futureMarkers))
        : Set<Marker>();
  }

  void _loadMarkers() async {
    List<Map<String, dynamic>> data = await _fetchSensorData();
    Set<Marker> loadedMarkers = await _createMarkers(data);
    setState(() {
      markers = loadedMarkers;
      locations_new = data;
    });
  }
  
 _onMapCreated(GoogleMapController controller)  {
    
    setState(() {
      mapController = controller;
    });
  }

  Color getColorForAQI(double aqi) {
  if (aqi >= 0 && aqi <= 40) {
      return Color(0xFF5D9913);
    } else if (aqi >= 41 && aqi <= 80) {
      return Color(0xFFE8B207);
    } 
    else if (aqi >= 81 && aqi <= 120) {
      return Color(0xFFD96607);
    } 
    else {
      return Colors.red;
    }
}

Color getColorForPM(double pm) {
  if (pm >= 0 && pm <= 40) {
      return Color(0xFF5D9913);
    } else if (pm >= 41 && pm <= 80) {
      return Color(0xFFE8B207);
    } 
    else if (pm >= 81 && pm <= 120) {
      return Color(0xFFD96607);
    } 
    else {
      return Colors.red;
    }
}

String getStringForPM(double pm) {
  if (pm >= 0 && pm <= 40) {
      return "Excellent";
    } else if (pm >= 41 && pm <= 80) {
      return "Good";
    } 
    else if (pm >= 81 && pm <= 120) {
      return "Bad";
    } 
    else {
      return "Unhealthy";
    }
}

String getStringForAQI(double aqi) {
  if (aqi >= 0 && aqi <= 40) {
      return "Excellent";
    } else if (aqi >= 41 && aqi <= 80) {
      return "Good";
    } 
    else if (aqi >= 81 && aqi <= 120) {
      return "Bad";
    } 
    else {
      return "Unhealthy";
    }
}

  void _onMarkerTapped(String sensorId, LatLng position, String title, String date, double aqi, double pm) {
    setState(() {
      selectedSensorId = sensorId;
      selectedPosition = position;
      _showPopup(context, position, title, date, aqi, pm);
    });
  }

  void _moveCameraToLocation(double lat, double lon) {
    mapController?.animateCamera(CameraUpdate.newLatLng(LatLng(lat, lon)));
  }

  void _showPopup(BuildContext context, LatLng position, String title, String date, double aqi, double pm) {
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
                        title,
                        style: TextStyle(
                          fontFamily: 'Work Sans',
                          color: Color(0xFF2E374C),
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
                    'Last Updated $date',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: "Work Sans",
                      color: Color(0xFFB0B0B0),
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'AIR QUALITY MEASURES',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF8E8C8C),
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
                          color: Color(0xFF2E374C),
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
                          color: getColorForAQI(aqi),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            aqi.floor().toString(),
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
                        getStringForAQI(aqi),
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
                          color: Color(0xFF2E374C),
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
                          color: getColorForPM(pm),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            pm.floor().toString(),
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
                        getStringForPM(pm),
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
      backgroundColor: Colors.transparent,
        appBar: null,
        body:Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color(0xFFE7E6F2),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                          child: ListView.separated(
                              separatorBuilder: (context, index) => Divider(),
                              itemCount: locations_new.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.fromLTRB(20, 16, 20, 20),
                                  child: GestureDetector(
                                    onTap: () {
              
                                      LatLng position = LatLng(
                                          locations_new[index]['lat'],
                                          locations_new[index]['lon']);
                                      _onMarkerTapped(
                                          locations_new[index]['id'], position, locations_new[index]['title'], locations_new[index]['timestamp'],locations_new[index]['aqi'], locations_new[index]['pm 2.5']);
                                      _moveCameraToLocation(
                                          locations_new[index]['lat'],
                                          locations_new[index]['lon']);
                                      // _showPopup(context, position);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              locations_new[index]['title'],
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFF2E374C),
                                                  fontFamily: "Work Sans",
                                                  fontWeight: FontWeight.w400,
                                                  ),
                                            ),
                                            const SizedBox(height: 6.0),
                                            Text(
                                              'QuantAQ: ${locations_new[index]['id']}',
                                              style: const TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Work Sans",
                                                color: Color(0xFF8E8C8C),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 80.0),
                                        SizedBox(
                                          width: 44.0,
                                          height: 44.0,
                                          child:
                                              Image.asset('gray_sensor_on.png'),
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
                                    zoom: 14.0,
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
            ));
  }


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

//   Future<Set<Marker>> _createMarkers() async {
//     final List<Future<Marker>> futureMarkers = locations_new.map((location) async {
//       print(location);
//       Color markerColor;
//       switch (location['color']) {
//         case 'green':
//           markerColor = Colors.green;
//           break;
//         case 'yellow':
//           markerColor = Colors.yellow;
//           break;
//         default:
//           markerColor = Colors.blue; // Default color
//       }
//       final BitmapDescriptor markerIcon =
//           await createCustomMarkerIcon(markerColor, "15");

//       return Marker(
//         markerId: MarkerId(location['id']),
//         position: LatLng(location['lat'], location['lon']),
//         // infoWindow: InfoWindow(
//         //   title: location['title'],
//         // ),
//         icon: markerIcon,
//         onTap: () {
//           _onMarkerTapped(
//               location['id'], LatLng(location['lat'], location['lon']));
//         },
//       );
//     }).toList();

//     return futureMarkers.isNotEmpty
//         ? Set<Marker>.from(await Future.wait(futureMarkers))
//         : Set<Marker>();
//   }
}


