import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final methodChannel = const MethodChannel('DIALOG');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
        onPressed: () async {
          final result =
              await methodChannel.invokeMethod('showDialog', 'Hello Shree');
          final message = jsonDecode(result);
          log(message['userId'].toString());
        },
        child: const Text('Show Dialog'),
      ),
    ));
  }
}
