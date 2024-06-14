import 'package:flutter/material.dart';
import 'maps_view.dart';
import 'summaryTable.dart';
import 'table_view.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _isMapView = true;
  bool _isTableView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: double.infinity, // Adjust the width as needed
        leading: const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Air Quality Elizabeth',
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Work Sans',
                  color: Color(0xFF2E374C)),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                hoverColor: Colors.transparent,
                onTap: () {
                  // Add your log out functionality here
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.logout, // Replace with the desired icon
                      size: 16.0, // Adjust the icon size as needed
                      color: Colors.grey, // Set the icon color
                    ),
                    SizedBox(
                        width:
                            4.0), // Add some spacing between the icon and text
                    Text(
                      'Log out',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Work Sans',
                        color: Color(0xFF8D8BA7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: Color(0xFFF4F6F9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 27.0, top: 16.0),
              child: Text(
                "Overview",
                style: TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2E374C)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0),
              child: Row(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isMapView = true;
                            _isTableView = false;
                          });
                        },
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered)) {
                              return Colors.transparent;
                            }
                            return Colors.transparent;
                          }),
                          foregroundColor: MaterialStateProperty.all<Color>(
                            _isMapView ? Colors.black : Colors.grey,
                          ),
                          textStyle: MaterialStateProperty.all<TextStyle>(
                            TextStyle(
                              color: Color(0xFF2E374C),
                              fontFamily: 'Work Sans',
                              fontSize: 24,
                              fontWeight: _isMapView
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                        ),
                        child: const Text('Map View'),
                      ),
                      if (_isMapView)
                        Positioned(
                          bottom:
                              -4, // Adjust this value to create space between text and underline
                          child: Container(
                            height: 7.0, // Thickness of the underline
                            width:
                                110.0, // Adjust this value to match the text width or set it dynamically
                            color: Color(0xFF3361FF),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 16.0),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isMapView = false;
                            _isTableView = true;
                          });
                        },
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered)) {
                              return Colors.transparent;
                            }
                            return Colors.transparent;
                          }),
                          foregroundColor: MaterialStateProperty.all<Color>(
                            _isTableView ? Colors.black : Colors.grey,
                          ),
                          textStyle: MaterialStateProperty.all<TextStyle>(
                            TextStyle(
                              color: Color(0xFF2E374C),
                              fontFamily: 'Work Sans',
                              fontSize: 24,
                              fontWeight: _isTableView
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                        ),
                        child: const Text('Table View'),
                      ),
                      if (_isTableView)
                        Positioned(
                          bottom:
                              -4, // Adjust this value to create space between text and underline
                          child: Container(
                            height: 7.0, // Thickness of the underline
                            width:
                                114.0, // Adjust this value to match the text width or set it dynamically
                            color: Color(0xFF3361FF),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 24, 40, 40),
                child: Container(
                  child: _isMapView ? MapPage() : TablePage(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
