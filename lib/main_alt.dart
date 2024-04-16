import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:google_maps/google_maps.dart' as gmaps;
import 'dart:ui' as ui;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sensor App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _sensorDataList = [];
  Timer? _timer;

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
    final response =
        await http.get(Uri.parse('http://128.6.238.29:5000/api/latest'));
    if (response.statusCode == 200) {
      setState(() {
        List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          Map<String, dynamic> sensorData = {
            'id': data[0],
            'timestamp': data[1],
            'timestamp_local': data[2],
            'sn': data[3],
            'co': data[4],
            'no': data[5],
            'no2': data[6],
            'o3': data[7],
            'pm1': data[8],
            'pm10': data[9],
            'pm25': data[10],
            'rh': data[11],
            'temp': data[12],
          };
          _sensorDataList = [
            sensorData,
            {
              'sn': 'AQ Sensor 1',
              'co': null,
              'no': null,
              'no2': null,
              'o3': null,
              'pm1': null,
              'pm10': null,
              'pm25': null,
              'rh': null,
              'temp': null,
            },
            {
              'sn': 'AQ Sensor 2',
              'co': null,
              'no': null,
              'no2': null,
              'o3': null,
              'pm1': null,
              'pm10': null,
              'pm25': null,
              'rh': null,
              'temp': null,
            },
            {
              'sn': 'AQ Sensor 3',
              'co': null,
              'no': null,
              'no2': null,
              'o3': null,
              'pm1': null,
              'pm10': null,
              'pm25': null,
              'rh': null,
              'temp': null,
            },
          ];
        }
      });
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(minutes: 5), (timer) {
      _fetchSensorData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A Web Page'),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            color: Colors.grey[200],
            child: Row(
              children: [
                Expanded(
                  child: Image.network(
                    'https://media.wired.com/photos/59269cd37034dc5f91bec0f1/master/pass/GoogleMapTA.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: 150,
                  color: Colors.white,
                  child: Table(
                    border: TableBorder.all(),
                    children: [
                      TableRow(children: [
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            color: Colors.green,
                            child: Text('Green'),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Text('AQ Lite'),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            color: Colors.yellow,
                            child: Text('Yellow'),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Text('AQ Lite 2'),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Filter'),
                      ),
                      SizedBox(width: 16.0),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Sort'),
                      ),
                      SizedBox(width: 16.0),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Add Sensor'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('Sensor Type')),
                            DataColumn(label: Text('Sensor ID')),
                            DataColumn(label: Text('Timestamp')),
                            DataColumn(label: Text('CO')),
                            DataColumn(label: Text('NO')),
                            DataColumn(label: Text('NO2')),
                            DataColumn(label: Text('O3')),
                            DataColumn(label: Text('PM1')),
                            DataColumn(label: Text('PM10')),
                            DataColumn(label: Text('PM25')),
                            DataColumn(label: Text('RH')),
                            DataColumn(label: Text('Temp')),
                            DataColumn(label: Text('Status')),
                          ],
                          rows: _sensorDataList.map((sensorData) {
                            return DataRow(cells: [
                              DataCell(Text('AQ Lite')),
                              DataCell(
                                  Text(sensorData['sn']?.toString() ?? '')),
                              DataCell(Text(
                                  sensorData['timestamp']?.toString() ?? '')),
                              DataCell(
                                  Text(sensorData['co']?.toString() ?? 'NULL')),
                              DataCell(
                                  Text(sensorData['no']?.toString() ?? 'NULL')),
                              DataCell(Text(
                                  sensorData['no2']?.toString() ?? 'NULL')),
                              DataCell(
                                  Text(sensorData['o3']?.toString() ?? 'NULL')),
                              DataCell(Text(
                                  sensorData['pm1']?.toString() ?? 'NULL')),
                              DataCell(Text(
                                  sensorData['pm10']?.toString() ?? 'NULL')),
                              DataCell(Text(
                                  sensorData['pm25']?.toString() ?? 'NULL')),
                              DataCell(
                                  Text(sensorData['rh']?.toString() ?? 'NULL')),
                              DataCell(Text(
                                  sensorData['temp']?.toString() ?? 'NULL')),
                              DataCell(Icon(Icons.check_circle,
                                  color: Colors.green)),
                            ]);
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
