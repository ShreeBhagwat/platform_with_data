import 'dart:developer';

import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callBackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    log("Task executed: $taskName");
    if(taskName == 'task-identifier') {
      log("Task executed: $taskName");
    }
    return Future.value(true);
  });
}
