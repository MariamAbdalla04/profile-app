import 'package:flutter/material.dart';
import 'package:myapp/home/home_screen/home_page.dart';
import 'package:myapp/first_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Tree App',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const MyHomePage(
        // Provide named parameters
      ),
      routes: {'/first': (context) => const Firstscreen()},
    );
  }
}
