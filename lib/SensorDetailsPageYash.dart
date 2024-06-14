import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SensorDetailsPageYash extends StatefulWidget {
  final String sensorName;
  SensorDetailsPageYash({Key? key, required this.sensorName}) : super(key: key);

  @override
  State<SensorDetailsPageYash> createState() => _SensorDetailsPageYashState();
}

class _SensorDetailsPageYashState extends State<SensorDetailsPageYash> {

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
    final double screenWidth = MediaQuery.of(context).size.width; 
    return Padding(padding: EdgeInsets.only(left : 40, right: 40, bottom: 40),
    child: Container(
      width: screenWidth,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
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
              label: Text('Update Time',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA6A9AA),
                  ))),
                DataColumn(label: Row(
                  children: [
                    Text('AQI',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA6A9AA),
                  )),
                  SizedBox(width: 2,),
                  Text('US',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFADABC3),
                  ))
                  ],
                )),
                DataColumn(label: Row(
                  children: [
                    Text('PM 2.5',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA6A9AA),
                  )),
                  SizedBox(width: 2,),
                  Text("μg/m³",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFADABC3),
                  ))
                  ],
                )),
                DataColumn(label: Row(
                  children: [
                    Text('PM 10',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA6A9AA),
                  )),
                  SizedBox(width: 2,),
                  Text("μg/m³",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFADABC3),
                  ))
                  ],
                )),
                DataColumn(label: Row(
                  children: [
                    Text('CO2',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA6A9AA),
                  )),
                  SizedBox(width: 2,),
                  Text("ppm",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFADABC3),
                  ))
                  ],
                )),
                DataColumn(label: Row(
                  children: [
                    Text('CO',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA6A9AA),
                  )),
                  SizedBox(width: 2,),
                  Text("ppm",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFADABC3),
                  ))
                  ],
                )),
                DataColumn(label: Row(
                  children: [
                    Text('O3',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA6A9AA),
                  )),
                  SizedBox(width: 2,),
                  Text("ppm",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFADABC3),
                  ))
                  ],
                )),
                DataColumn(label: Row(
                  children: [
                    Text('NO',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA6A9AA),
                  )),
                  SizedBox(width: 2,),
                  Text("ppm",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFADABC3),
                  ))
                  ],
                )),
                DataColumn(label: Row(
                  children: [
                    Text('NO2',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA6A9AA),
                  )),
                  SizedBox(width: 2,),
                  Text("ppm",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFADABC3),
                  ))
                  ],
                )),
                DataColumn(label: Row(
                  children: [
                    Text('TEMP',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA6A9AA),
                  )),
                  SizedBox(width: 2,),
                  Text("℉",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFADABC3),
                  ))
                  ],
                )),
                DataColumn(label: Row(
                  children: [
                    Text('HUMIDITY',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA6A9AA),
                  )),
                  SizedBox(width: 2,),
                  Text("%",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFADABC3),
                  ))
                  ],
                )),
                DataColumn(label: Row(
                  children: [
                    Text('PRESSURE',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA6A9AA),
                  )),
                  SizedBox(width: 2,),
                  Text("Hg",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFADABC3),
                  ))
                  ],
                )),
                DataColumn(
              label: Text('Status',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA6A9AA),
                  ))),
        ],
        rows: [],
          ),
        ),
      ),
    ),
    );
  }
}