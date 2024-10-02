import 'package:flutter/material.dart';
import 'package:girman_search_app/data/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:girman_search_app/screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const GirmanSearchApp(),
    ),
  );
}

class GirmanSearchApp extends StatelessWidget {
  const GirmanSearchApp({super.key});

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
