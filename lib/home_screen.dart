import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:platform_channel/notification_handler.dart';
import 'package:workmanager/workmanager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _determinePosition();
  }

  final methodChannel = const MethodChannel('DIALOG');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
        onPressed: () async {
          // platfromCallDialog();

          // final eventChannel = await EventChannel('event_channel')
          //     .receiveBroadcastStream()
          //     .listen((event) {
          //   log(event.toString());
          // });
          // log('Notification func called');
          // NotificationHandler().showNotification('Hello');
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
    Workmanager().registerOneOffTask('1', 'task-identifier');
  }

  void workManagerPeriodicCallback() {
    Workmanager().registerPeriodicTask(
      "task-identifier",
      "task-identifier",
      initialDelay: const Duration(seconds: 5),
    );
  }

  Future getBackgroundLocation() async {
    await Workmanager().registerOneOffTask("1", "fetch-location",
        // frequency: const Duration(minutes: 15),
        inputData: {});
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    log(Geolocator.getCurrentPosition().toString());
    return await Geolocator.getCurrentPosition();
  }
}
