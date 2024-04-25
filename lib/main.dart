import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'login_page.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'AQ Dashboard',
        theme: ThemeData(
          primarySwatch: Colors.lime,
        ),
        home: LoginPage() //HomePage(),
        );
  }
}
