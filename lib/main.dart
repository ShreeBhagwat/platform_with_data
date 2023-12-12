import 'package:flutter/material.dart';
import 'package:platform_channel/event_channel_flutter.dart';
import 'package:platform_channel/home_screen.dart';
import 'package:platform_channel/workmanager_service.dart';
import 'package:workmanager/workmanager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callBackDispatcher, isInDebugMode: true);
  runApp(PlatfromDialog());
}

class PlatfromDialog extends StatelessWidget {
  const PlatfromDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EventChannelFlutter()
    );
  }
}
