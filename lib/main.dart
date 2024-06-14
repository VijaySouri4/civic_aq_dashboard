import 'dart:collection';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'login_page.dart';
// import 'home_page.dart';
import 'summaryTable.dart';
// import 'map.dart';
import 'maps_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AQ Dashboard',
      theme: ThemeData(
          primarySwatch: Colors.lime,
          textTheme: GoogleFonts.workSansTextTheme() //,TextTheme(
          //   // displayLarge: TextStyle(fontFamily: 'WorkSans'),
          //   // displayMedium: TextStyle(fontFamily: 'WorkSans'),
          //   // displaySmall: TextStyle(fontFamily: 'WorkSans'),
          //   // headlineLarge: TextStyle(fontFamily: 'WorkSans'),
          //   // headlineMedium: TextStyle(fontFamily: 'WorkSans'),
          //   // headlineSmall: TextStyle(fontFamily: 'WorkSans'),
          //   // titleLarge: TextStyle(fontFamily: 'WorkSans'),
          //   // titleMedium: TextStyle(fontFamily: 'WorkSans'),
          //   // titleSmall: TextStyle(fontFamily: 'WorkSans'),
          //   // bodyLarge: TextStyle(fontFamily: 'WorkSans'),
          //   // bodyMedium: TextStyle(fontFamily: 'WorkSans'),
          //   // bodySmall: TextStyle(fontFamily: 'WorkSans'),
          //   // labelLarge: TextStyle(fontFamily: 'WorkSans'),
          //   // labelMedium: TextStyle(fontFamily: 'WorkSans'),
          //   // labelSmall: TextStyle(fontFamily: 'WorkSans'),
          //   textTheme: GoogleFonts.workSansTextTheme(),
          // ),
          ),
      home: FutureBuilder(
        future: _checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show loading indicator while waiting
          } else if (snapshot.hasData && snapshot.data == true) {
            return DashboardPage(); // User is logged in, show the map page
          } else {
            return DashboardPage(); // User is not logged in, show the login page
          }
        },
      ),
    );
  }

  Future<bool> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}
