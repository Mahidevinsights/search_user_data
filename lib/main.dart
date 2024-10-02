import 'package:flutter/material.dart';
import 'package:girman_search_app/screens/home_screen.dart';

void main() {
  runApp(GirmanSearchApp());
}

class GirmanSearchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Girman Technologies Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
