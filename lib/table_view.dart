import 'package:flutter/material.dart';
import 'summaryTable.dart';

class TablePage extends StatefulWidget {
  const TablePage({super.key});

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(padding: EdgeInsets.only(left : 40, right: 40, bottom: 40),
    child: Container(
      width: screenWidth,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Summarytable(),
      ),
    ),
    );
  }
}