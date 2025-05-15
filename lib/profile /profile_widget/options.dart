import 'dart:io';
import 'package:flutter/material.dart';

class Options extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? color;
  final VoidCallback onPressed;

  const Options({
    required this.onPressed,
    this.color,
    required this.title,
    required this.icon,
    super.key, File? selectedImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: color ?? Colors.black),
        ),
        Text(title),
      ],
    );
  }
}
