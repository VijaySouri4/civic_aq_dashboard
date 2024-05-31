import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'SensorDetailsPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
        _sensorDataList = data.map((item) {
          return {
            'id': item['data'][0],
            'timestamp': item['data'][1],
            'timestamp_local': item['data'][2],
            'sn': item['data'][3],
            'co': item['data'][4],
            'no': item['data'][5],
            'no2': item['data'][6],
            'o3': item['data'][7],
            'pm1': item['data'][8],
            'pm10': item['data'][9],
            'pm25': item['data'][10],
            'rh': item['data'][11],
            'temp': item['data'][12],
            'status': 'active' // Add a status or other fields as needed
          };
        }).toList();
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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
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
                DataCell(InkWell(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SensorDetailsPage(
                                sensorName: sensorData['sn'])))
                  },
                  child: const Text('MODULAIR'),
                )),
                DataCell(Text(sensorData['sn']?.toString() ?? '')),
                DataCell(Text(sensorData['timestamp']?.toString() ?? '')),
                DataCell(Text(sensorData['co']?.toString() ?? 'NULL')),
                DataCell(Text(sensorData['no']?.toString() ?? 'NULL')),
                DataCell(Text(sensorData['no2']?.toString() ?? 'NULL')),
                DataCell(Text(sensorData['o3']?.toString() ?? 'NULL')),
                DataCell(Text(sensorData['pm1']?.toString() ?? 'NULL')),
                DataCell(Text(sensorData['pm10']?.toString() ?? 'NULL')),
                DataCell(Text(sensorData['pm25']?.toString() ?? 'NULL')),
                DataCell(Text(sensorData['rh']?.toString() ?? 'NULL')),
                DataCell(Text(sensorData['temp']?.toString() ?? 'NULL')),
                DataCell(Icon(Icons.check_circle, color: Colors.green)),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
