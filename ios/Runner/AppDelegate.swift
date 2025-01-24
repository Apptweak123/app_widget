import Flutter
import UIKit
import home_widget
import workmanager

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      
      UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(60 * 15))

      WorkmanagerPlugin.setPluginRegistrantCallback { registry in
          GeneratedPluginRegistrant.register(with: registry)
      }

      if #available(iOS 17, *) {
        HomeWidgetBackgroundWorker.setPluginRegistrantCallback { registry in
            GeneratedPluginRegistrant.register(with: registry)
        }
          
      }
      
      
      // Add MethodChannel for saving data to App Group
         let controller = self.window?.rootViewController as! FlutterViewController
         let appGroupChannel = FlutterMethodChannel(name: "appGroupChannel", binaryMessenger: controller.binaryMessenger)
         
         appGroupChannel.setMethodCallHandler { (call, result) in
             if call.method == "saveToAppGroup" {
                 if let args = call.arguments as? [String: Any],
                    let key = args["key"] as? String,
                    let value = args["value"] as? String {
                     let sharedDefaults = UserDefaults(suiteName: "group.com.example.appwidget.HomeWidgetExample")
                     sharedDefaults?.set(value, forKey: key)
                     result("Data saved successfully")
                 } else {
                     result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid arguments", details: nil))
                 }
             } else {
                 result(FlutterMethodNotImplemented)
             }
         }
      
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    
}
