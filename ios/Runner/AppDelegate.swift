import UIKit
import Flutter
import workmanager
import flutter_local_notifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    WorkmanagerPlugin.registerTask(withIdentifier: "task-identifier")
    
 FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
    GeneratedPluginRegistrant.register(with: registry)
  }
  
    if #available(iOS 10.0, *) {
  UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
}
    let controller = window?.rootViewController as! FlutterViewController
    let channel = FlutterEventChannel(name: "event_channel", binaryMessenger: controller.binaryMessenger)
    
    channel.setStreamHandler(MyEventHandler())

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

class MyEventHandler: NSObject, FlutterStreamHandler{
  var timer = Timer()
  private var eventSink1: FlutterEventSink?
  
  func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    print("On listen called")
    eventSink1 = events
    
    self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
      let dateFormat = DateFormatter()
      dateFormat.dateFormat = "hh:mm:ss"
      let time = dateFormat.string(from: Date())
      self.eventSink1!(time)
    })
    
    return nil
  }
  
  func onCancel(withArguments arguments: Any?) -> FlutterError? {
    eventSink1 = nil
    return nil
  }
}
