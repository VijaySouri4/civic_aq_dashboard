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
  late Future<List<dynamic>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = fetchData();
  }

  Future<List<dynamic>> fetchData() async {
    var url = Uri.parse(
        'https://civic-aq-dashboard.com/api/data_${widget.sensorName}');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      // return json.decode(response.body);
      List<dynamic> data = json.decode(response.body);
      return data.reversed.toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sensorName),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            return SingleChildScrollView(
              child: PaginatedDataTable(
                header: const Text('Sensor Data'),
                rowsPerPage: 10,
                columns: const [
                  // DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Server Time Stamp')),
                  // DataColumn(label: Text('End Time')),
                  DataColumn(label: Text('Device ID')),
                  DataColumn(label: Text('co')),
                  DataColumn(label: Text('no')),
                  DataColumn(label: Text('no2')),
                  DataColumn(label: Text('o3')),
                  DataColumn(label: Text('pm1')),
                  DataColumn(label: Text('pm10')),
                  DataColumn(label: Text('pm25')),
                  DataColumn(label: Text('rh')),
                  DataColumn(label: Text('temp')),
                  DataColumn(label: Text('geo_lat')),
                  DataColumn(label: Text('geo_lon')),
                  DataColumn(label: Text('met_rh')),
                  DataColumn(label: Text('met_temp')),
                  DataColumn(label: Text('met_wd')),
                  DataColumn(label: Text('met_ws')),
                  DataColumn(label: Text('model_gas_co')),
                  DataColumn(label: Text('model_gas_no')),
                  DataColumn(label: Text('model_gas_no2')),
                  DataColumn(label: Text('model_gas_o3')),
                  DataColumn(label: Text('model_pm_pm1')),
                  DataColumn(label: Text('model_pm_pm10')),
                  DataColumn(label: Text('model_pm_pm25')),
                  // Add more columns as per your data
                ],
                source: _DataSource(context, snapshot.data!),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final BuildContext context;
  final List<dynamic> data;

  _DataSource(this.context, this.data);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= data.length) return null!;
    final row = data[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(row[1].toString())), // Adjust according to actual data
        DataCell(Text(row[3].toString())),
        DataCell(Text(row[4].toString())),
        DataCell(Text(row[5].toString())),
        DataCell(Text(row[6].toString())),
        DataCell(Text(row[7].toString())),
        DataCell(Text(row[8].toString())),
        DataCell(Text(row[9].toString())),
        DataCell(Text(row[10].toString())),
        DataCell(Text(row[11].toString())),
        DataCell(Text(row[12].toString())),
        DataCell(Text(row[13].toString())),
        DataCell(Text(row[14].toString())),
        DataCell(Text(row[15].toString())),
        DataCell(Text(row[16].toString())),
        DataCell(Text(row[17].toString())),
        DataCell(Text(row[18].toString())),
        DataCell(Text(row[19].toString())),
        DataCell(Text(row[20].toString())),
        DataCell(Text(row[21].toString())),
        DataCell(Text(row[22].toString())),
        DataCell(Text(row[23].toString())),
        DataCell(Text(row[24].toString())),
        DataCell(Text(row[25].toString())),
        // More cells as per your data
      ],
    );
  }

  @override
  int get rowCount => data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
