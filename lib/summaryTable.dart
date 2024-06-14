import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:intl/intl.dart';
import 'SensorDetailsPageYash.dart';
import 'SensorDetailsPage.dart';

class Summarytable extends StatefulWidget {
  const Summarytable({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Summarytable> {
  List<Map<String, dynamic>> _sensorDataList = [];
  Timer? _timer;

  final Map<String, String> sensorNames = {
    'MOD-00648': 'Mravlag, Building B',
    'MOD-00638': 'Mravlag, Building K',
    'MOD-00641': 'Kennedy Arms',
    'MOD-00646': 'Ford Leonard',
    'MOD-00642': 'E-Port Center',
    'MOD-00640': 'Mravlag, Building L',
    'MOD-00639': 'Marina Village',
    'MOD-00643': "O'Donnell Dempsey",
    'MOD-00647': 'Farley Towers',
    'MOD-00599': 'Mod 599',
  };

  @override
  void initState() {
    super.initState();
    _fetchSensorData();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _fetchSensorData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://civic-aq-dashboard.com/api/latest')); //('https://128.6.238.29:5000/api/latest'));
      // print('Response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        // print('Data fetched: $data');
        List<Map<String, dynamic>> parsedData = data.map((item) {
          final sensorData = item['data'];
          final timestamp = sensorData[1];
          DateTime gmtTime = DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'")
              .parse(timestamp, true);
          DateTime localTime = gmtTime.toLocal();
          final localTimestamp = DateFormat('MMMM d, HH:mm').format(localTime);

          final pm1 = sensorData[8] != null ? double.parse(sensorData[8]) : 0.0;
          final pm10 =
              sensorData[9] != null ? double.parse(sensorData[9]) : 0.0;
          final pm25 =
              sensorData[10] != null ? double.parse(sensorData[10]) : 0.0;
          final aqi = [pm1, pm10, pm25].reduce((a, b) => a > b ? a : b);
          final co = sensorData[4] != null ? double.parse(sensorData[4]) : 0.0;
          final no = sensorData[5] != null ? double.parse(sensorData[5]) : 0.0;
          final no2 = sensorData[6] != null ? double.parse(sensorData[6]) : 0.0;
          final o3 = sensorData[7] != null ? double.parse(sensorData[7]) : 0.0;
          final pm2point5 = 0.0;
          final co2 = 0.0;
          final sensor_id = sensorData[3] != null ? sensorData[3] : "#000";
          final sensor_id_final = sensor_id.replaceAll('-', '');

          // print(
          //     'Sensor ID: ${sensorData[3]}, Timestamp: $localTimestamp, AQI: $aqi');

          return {
            'device_name': sensorNames[sensorData[3]] ?? sensorData[3],
            'timestamp': localTimestamp,
            'aqi': aqi,
            'status': 'active', // Status remains the same
            'co': co,
            'no': no,
            'no2': no2,
            'o3': o3,
            'pm1': pm1,
            'pm10': pm10,
            'pm 2.5': pm2point5, // missing
            'co2': co2, //missing
            'sensor_id': sensor_id_final,
            
          };
        }).toList();

        setState(() {
          _sensorDataList = parsedData;
        });
      } else {
        print('Failed to load data: ${response.body}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      _fetchSensorData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: Color(0xFF55607799),
              width: 1.0,
            ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        dataRowMaxHeight: double.infinity,
        headingRowColor: MaterialStateProperty.all<Color>(Color(0xFFFAFAFF)),
        columns: const [
          DataColumn(
              label: Text('Device Name',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA6A9AA),
                  ))),
          
          DataColumn(
              label: Text('Last Updated',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA6A9AA),
                  ))),
          DataColumn(
              label: Text('CO',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA6A9AA),
                  ))),
          DataColumn(
              label: Text('NO',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA6A9AA),
                  ))),
          DataColumn(
              label: Text('NO2',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA6A9AA),
                  ))),
          DataColumn(
              label: Text('O3',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA6A9AA),
                  ))),
          DataColumn(
              label: Text('PM1',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA6A9AA),
                  ))),
          DataColumn(
              label: Text('PM10',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA6A9AA),
                  ))),
          DataColumn(
              label: Text('AQI',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA6A9AA),
                  ))),
          DataColumn(
              label: Text('PM 2.5 (µg/m³)',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA6A9AA),
                  ))),
          DataColumn(
              label: Text('CO2 (ppm)',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA6A9AA),
                  ))),
                  DataColumn(
              label: Text('Status',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA6A9AA),
                  ))),
          // DataColumn(
          //     label: Text('TEMP',
          //         textAlign: TextAlign.left,
          //         style: TextStyle(
          //           fontSize: 14,
          //           fontWeight: FontWeight.w500,
          //           color: Color(0xFFA6A9AA),
          //         ))),
          // DataColumn(
          //     label: Text('HUMIDITY',
          //         textAlign: TextAlign.left,
          //         style: TextStyle(
          //           fontSize: 14,
          //           fontWeight: FontWeight.w500,
          //           color: Color(0xFFA6A9AA),
          //         ))),
          // DataColumn(
          //     label: Text('PRESSURE',
          //         textAlign: TextAlign.left,
          //         style: TextStyle(
          //           fontSize: 14,
          //           fontWeight: FontWeight.w500,
          //           color: Color(0xFFA6A9AA),
          //         ))),
        ],
        rows: _sensorDataList.map((sensorData) {
          return DataRow(cells: [
            DataCell(
              GestureDetector(
                onTap: () {
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SensorDetailsPage(sensorName: sensorData['sensor_id'] ?? '')), 
      );
      },
                child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sensorData['device_name'] ?? '',
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF3361FF),
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFF3361FF),),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      'QuantAQ: ${sensorData['sensor_id'] ?? ''}',
                      style: const TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF8E8C8C),
                      ),
                    ),
                  ],
                ),
              ),
              )
            ),
            
            DataCell(Text(
              sensorData['timestamp'].toString(),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF2E374C),
                  fontFamily: "Work Sans",),
            )),
            DataCell(Text(
              sensorData['co'].toString(),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF2E374C),
                  fontFamily: "Work Sans"),
            )),
            DataCell(Text(
              sensorData['no'].toString(),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF2E374C),
                  fontFamily: "Work Sans"),
            )),
            DataCell(Text(
              sensorData['no2'].toString(),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF2E374C),
                  fontFamily: "Work Sans"),
            )),
            DataCell(Text(
              sensorData['o3'].toString(),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF2E374C),
                  fontFamily: "Work Sans"),
            )),
            DataCell(Text(
              sensorData['pm1'].toString(),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF2E374C),
                  fontFamily: "Work Sans"),
            )),
            DataCell(Text(
              sensorData['pm10'].toString(),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF2E374C),
                  fontFamily: "Work Sans"),
            )),
            DataCell(Text(
              sensorData['aqi'].toString(),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF2E374C),
                  fontFamily: "Work Sans"),
            )),
            DataCell(Text(
              sensorData['pm 2.5'].toString(),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF2E374C),
                  fontFamily: "Work Sans"),
            )),
            DataCell(Text(
              sensorData['co2'].toString(),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF2E374C),
                  fontFamily: "Work Sans"),
            )),
            DataCell(Row(
              children: [
                Image.asset(
                  sensorData['status'] == 'active'
                      ? 'green_sensor.png'
                      : 'red_sensor.png',
                  width: 24,
                  height: 24,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  sensorData['status'] == "active" ? "Active" : "Inactive",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: sensorData['status'] == 'active'
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ],
            )),
            // DataCell(Text(
            //   sensorData['temp'].toString(),
            //   style: const TextStyle(
            //       fontSize: 16,
            //       fontWeight: FontWeight.w400,
            //       color: Colors.black),
            // )),
            // DataCell(Text(
            //   sensorData['pressure'].toString(),
            //   style: const TextStyle(
            //       fontSize: 16,
            //       fontWeight: FontWeight.w400,
            //       color: Colors.black),
            // )),
            // DataCell(Text(
            //   sensorData['humidity'].toString(),
            //   style: const TextStyle(
            //       fontSize: 16,
            //       fontWeight: FontWeight.w400,
            //       color: Colors.black),
            // )),
          ]);
        }).toList(),
      ),
    );
   
    
  }
}
