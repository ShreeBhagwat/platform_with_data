import 'package:flutter/material.dart';
import 'package:platform_channel/home_screen.dart';

void main() {
  runApp(PlatfromDialog());
}

class PlatfromDialog extends StatelessWidget {
  const PlatfromDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
