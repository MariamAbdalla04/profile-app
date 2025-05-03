import 'package:flutter/material.dart';

class MyFruit extends StatelessWidget {
  final String url;
  final String text;

  const MyFruit({required this.url, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(url, height: 100, width: 100, fit: BoxFit.cover),
        Container(
          color: Colors.black54,
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}