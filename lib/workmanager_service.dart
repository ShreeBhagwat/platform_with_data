import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:platform_channel/notification_handler.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callBackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    log("Task executed: $taskName");
    if (taskName == 'fetch-location') {
      log("Task executed: $taskName");
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      log(position.toString());
         await NotificationHandler().showNotification(position.toString());
    }
    return Future.value(true);
  });
}
