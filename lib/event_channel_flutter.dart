import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EventChannelFlutter extends StatelessWidget {
  const EventChannelFlutter({super.key});

  final eventChannel = const EventChannel('event_channel');

  Stream<String> streamFromNative() {
    return eventChannel
        .receiveBroadcastStream()
        .map((event) => event.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<String>(
          stream: streamFromNative(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Error');
            }
            if (snapshot.hasData) {
              return Text(snapshot.data!);
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
