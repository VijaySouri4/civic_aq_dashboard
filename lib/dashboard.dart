import 'package:flutter/material.dart';
import 'maps_view.dart';
import 'summaryTable.dart';

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
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: InkWell(
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
                        color: Colors.black,
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
        color: Color.fromARGB(255, 242, 241, 238),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                          foregroundColor: MaterialStateProperty.all<Color>(
                            _isMapView ? Colors.black : Colors.grey,
                          ),
                          textStyle: MaterialStateProperty.all<TextStyle>(
                            TextStyle(
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
                            color: Colors.blue,
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
                          foregroundColor: MaterialStateProperty.all<Color>(
                            _isTableView ? Colors.black : Colors.grey,
                          ),
                          textStyle: MaterialStateProperty.all<TextStyle>(
                            TextStyle(
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
                            color: Colors.blue,
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
                  child: _isMapView ? MapPage() : const Summarytable(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
