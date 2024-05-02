import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SensorDetailsPage extends StatefulWidget {
  final String sensorName;

  SensorDetailsPage({Key? key, required this.sensorName}) : super(key: key);

  @override
  _SensorDetailsPageState createState() => _SensorDetailsPageState();
}

class _SensorDetailsPageState extends State<SensorDetailsPage> {
  List<dynamic> sensorData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var url = Uri.parse('http://128.6.238.29:5000/api/data');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        sensorData = json.decode(response.body);
      });
      print(sensorData);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Start Time')),
            DataColumn(label: Text('End Time')),
            DataColumn(label: Text('Device ID')),
            DataColumn(label: Text('PM2.5')),
            DataColumn(label: Text('Temperature')),
            DataColumn(label: Text('Humidity')),
            // Add more columns as per your data
          ],
          rows: sensorData.map((data) {
            return DataRow(cells: [
              DataCell(Text(data[0].toString())),
              DataCell(Text(data[1].toString())),
              DataCell(Text(data[2].toString())),
              DataCell(Text(data[3].toString())),
              DataCell(Text(data[4].toString())),
              DataCell(Text(data[5].toString())),
              DataCell(Text(data[6].toString())),
              // Add more cells as per your data
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
