import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workmanager/workmanager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final methodChannel = const MethodChannel('DIALOG');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
        onPressed: () async {
          // platfromCallDialog();
          // workManagerCall();
          workManagerPeriodicCallback();
        },
        child: const Text('Show Dialog'),
      ),
    ));
  }

  void platfromCallDialog() async {
    final result =
        await methodChannel.invokeMethod('showDialog', 'Hello Shree');
    final message = jsonDecode(result);
    log(message['userId'].toString());
  }

  void workManagerCall() {
    Workmanager().registerOneOffTask('task-identifier', 'task-identifier');
  }

  void workManagerPeriodicCallback() {
    Workmanager().registerPeriodicTask(
      'task-identifier',
      'task-identifier',
      frequency: Duration(minutes: 20),
    );
 
  }
}
