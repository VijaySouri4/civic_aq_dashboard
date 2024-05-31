import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:intl/intl.dart';

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
          final localTimestamp =
              DateFormat('MM-dd-yy   HH:mm').format(localTime);

          final pm1 = sensorData[8] != null ? double.parse(sensorData[8]) : 0.0;
          final pm10 =
              sensorData[9] != null ? double.parse(sensorData[9]) : 0.0;
          final pm25 =
              sensorData[10] != null ? double.parse(sensorData[10]) : 0.0;
          final aqi = [pm1, pm10, pm25].reduce((a, b) => a > b ? a : b);

          print(
              'Sensor ID: ${sensorData[3]}, Timestamp: $localTimestamp, AQI: $aqi');

          return {
            'device_name': sensorNames[sensorData[3]] ?? sensorData[3],
            'timestamp': localTimestamp,
            'aqi': aqi,
            'status': 'active', // Status remains the same
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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SelectionArea(
        child: Container(
          width: double.infinity,
          child: DataTable(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 8.0,
              ),
            ),
            columns: [
              DataColumn(label: Text('Device Name')),
              DataColumn(label: Text('Timestamp')),
              DataColumn(label: Text('AQI')),
              DataColumn(label: Text('Status')),
            ],
            rows: _sensorDataList.map((sensorData) {
              return DataRow(cells: [
                DataCell(Text(sensorData['device_name'] ?? '')),
                DataCell(Text(sensorData['timestamp'] ?? '')),
                DataCell(Text(sensorData['aqi'].toString())),
                DataCell(Icon(Icons.check_circle, color: Colors.green)),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
