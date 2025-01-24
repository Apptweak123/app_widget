// import 'dart:io';
// import 'dart:math';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:home_widget/home_widget.dart';
// import 'package:workmanager/workmanager.dart';
//
// @pragma("vm:entry-point")
// void callbackDispatcher() async {
//   Workmanager().executeTask((taskName, inputData) {
//     final now = DateTime.now();
//     return Future.wait<bool?>([
//       HomeWidget.saveWidgetData(
//         'title',
//         'Updated from Background',
//       ),
//       HomeWidget.saveWidgetData(
//         'message',
//         '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}',
//       ),
//     ]).then((value) async {
//       Future.wait<bool?>([
//         HomeWidget.updateWidget(
//           name: 'AppWidgetExampleProvider',
//           //iOSName: 'HomeWidgetExample',
//         ),
//         if (Platform.isAndroid)
//           HomeWidget.updateWidget(
//             qualifiedAndroidName:
//             'com.example.appwidget.glance.HomeWidgetReceiver',
//           ),
//       ]);
//       return !value.contains(false);
//     });
//   });
// }
//
// /// Called when Doing Background Work initiated from Widget
// @pragma("vm:entry-point")
// Future<void> interactiveCallback(Uri? data) async {
//   if (data?.host == 'titleclicked') {
//     final greetings = [
//       'Hello',
//       'Hallo',
//       'Bonjour',
//       'Hola',
//       'Ciao',
//       '哈洛',
//       '안녕하세요',
//       'xin chào',
//     ];
//     final selectedGreeting = greetings[Random().nextInt(greetings.length)];
//     await HomeWidget.setAppGroupId('YOUR_GROUP_ID');
//     await HomeWidget.saveWidgetData<String>('title', selectedGreeting);
//     await HomeWidget.updateWidget(
//       name: 'AppWidgetExampleProvider',
//       iOSName: 'HomeWidgetExample',
//     );
//     if (Platform.isAndroid) {
//       await HomeWidget.updateWidget(
//         qualifiedAndroidName:
//         'com.example.appwidget.glance.HomeWidgetReceiver',
//       );
//     }
//   }
// }
//
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   Workmanager().initialize(callbackDispatcher, isInDebugMode: kDebugMode);
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   bool _isRequestPinWidgetSupported = false;
//
//   @override
//   void initState() {
//     super.initState();
//     super.initState();
//     HomeWidget.setAppGroupId('YOUR_GROUP_ID');
//     HomeWidget.registerInteractivityCallback(interactiveCallback);
//     _checkPinability();
//   }
//
//   Future<void> _checkPinability() async {
//     final isRequestPinWidgetSupported =
//     await HomeWidget.isRequestPinWidgetSupported();
//     if (mounted) {
//       setState(() {
//         _isRequestPinWidgetSupported = isRequestPinWidgetSupported ?? false;
//       });
//     }
//   }
//
//
//
//
//   void _incrementCounter() {
//
//     HomeWidget.requestPinWidget(
//       qualifiedAndroidName:
//       'com.example.appwidget.glance.HomeWidgetReceiver',
//     );
//
//     setState(() {
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:workmanager/workmanager.dart';

/// Used for Background Updates using Workmanager Plugin
@pragma("vm:entry-point")
void callbackDispatcher() async {
  Workmanager().executeTask((taskName, inputData) {
    final now = DateTime.now();
    return Future.wait<bool?>([
      HomeWidget.saveWidgetData(
        'title',
        'Updated from Background',
      ),
      HomeWidget.saveWidgetData(
        'message',
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}',
      ),
    ]).then((value) async {
      Future.wait<bool?>([
        HomeWidget.updateWidget(
          name: 'HomeWidgetExampleProvider',
          iOSName: 'HomeWidgetExample',
        ),
        if (Platform.isAndroid)
          HomeWidget.updateWidget(
            qualifiedAndroidName: 'com.example.appwidget.glance.HomeWidgetReceiver',
          ),
      ]);
      return !value.contains(false);
    });
  });
}

/// Called when Doing Background Work initiated from Widget
@pragma("vm:entry-point")
Future<void> interactiveCallback(Uri? data) async {
  if (data?.host == 'titleclicked') {
    final greetings = [
      'Hello',
      'Hallo',
      'Bonjour',
      'Hola',
      'Ciao',
      '哈洛',
      '안녕하세요',
      'xin chào',
    ];
    final selectedGreeting = greetings[Random().nextInt(greetings.length)];
    if (Platform.isAndroid) {
      await HomeWidget.setAppGroupId('YOUR_GROUP_ID');
    } else {
      await HomeWidget.setAppGroupId("group.com.example.appwidget.HomeWidgetExample");
    }
    await HomeWidget.saveWidgetData<String>('title', selectedGreeting);
    await HomeWidget.updateWidget(
      name: 'HomeWidgetExampleProvider',
      iOSName: 'HomeWidgetExample',
    );
    if (Platform.isAndroid) {
      await HomeWidget.updateWidget(
        qualifiedAndroidName: 'com.example.appwidget.glance.HomeWidgetReceiver',
      );
    }
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: kDebugMode);
  runApp(const MaterialApp(home: MyApp()));

  // print('My Prayer Times');
  // final myCoordinates = Coordinates(31.4648654, 74.249673); // Replace with your own location lat, lng.
  // final params = CalculationMethod.karachi.getParameters();
  // params.madhab = Madhab.hanafi;
  // final prayerTimes = PrayerTimes.today(myCoordinates, params);
  //
  // print("---Today's Prayer Times in Your Local Timezone(${prayerTimes.fajr.timeZoneName})---");
  // print(DateFormat.jm().format(prayerTimes.fajr));
  // print(DateFormat.jm().format(prayerTimes.sunrise));
  // print(DateFormat.jm().format(prayerTimes.dhuhr));
  // print(DateFormat.jm().format(prayerTimes.asr));
  // print(DateFormat.jm().format(prayerTimes.maghrib));
  // print(DateFormat.jm().format(prayerTimes.isha));
  //
  // print('---');
  //
  // // Custom Timezone Usage. (Most of you won't need this).
  // print('NewYork Prayer Times');
  // final newYork = Coordinates(35.7750, -78.6336);
  // final nyUtcOffset = Duration(hours: -4);
  // final nyDate = DateComponents(2015, 7, 12);
  // final nyParams = CalculationMethod.north_america.getParameters();
  // nyParams.madhab = Madhab.hanafi;
  // final nyPrayerTimes = PrayerTimes(newYork, nyDate, nyParams, utcOffset: nyUtcOffset);
  //
  // print(nyPrayerTimes.fajr.timeZoneName);
  // print(DateFormat.jm().format(nyPrayerTimes.fajr));
  // print(DateFormat.jm().format(nyPrayerTimes.sunrise));
  // print(DateFormat.jm().format(nyPrayerTimes.dhuhr));
  // print(DateFormat.jm().format(nyPrayerTimes.asr));
  // print(DateFormat.jm().format(nyPrayerTimes.maghrib));
  // print(DateFormat.jm().format(nyPrayerTimes.isha));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isRequestPinWidgetSupported = false;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      HomeWidget.setAppGroupId('YOUR_GROUP_ID');
    } else {
      HomeWidget.setAppGroupId("group.com.example.appwidget.HomeWidgetExample");
    }
    HomeWidget.registerInteractivityCallback(interactiveCallback);
    _checkPinability();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkForWidgetLaunch();
    HomeWidget.widgetClicked.listen(_launchedFromWidget);
  }

  // Future _sendData() async {
  //   try {
  //     return Future.wait([
  //       HomeWidget.renderFlutterWidget(
  //         const Icon(
  //           Icons.flutter_dash,
  //           size: 200,
  //         ),
  //         logicalSize: const Size(200, 200),
  //         key: 'dashIcon',
  //       ),
  //     ]);
  //   } on PlatformException catch (exception) {
  //     debugPrint('Error Sending Data. $exception');
  //   }
  // }

  // Future _updateWidget() async {
  //   try {
  //     return Future.wait([
  //       HomeWidget.updateWidget(
  //         name: 'HomeWidgetExampleProvider',
  //         // iOSName: '
  //         // ',
  //       ),
  //       if (Platform.isAndroid)
  //         HomeWidget.updateWidget(
  //           qualifiedAndroidName: 'com.example.appwidget.glance.HomeWidgetReceiver',
  //         ),
  //     ]);
  //   } on PlatformException catch (exception) {
  //     debugPrint('Error Updating Widget. $exception');
  //   }
  // }

  // Future<void> _sendAndUpdate() async {
  //   await _sendData();
  //   await _updateWidget();
  // }

  void _checkForWidgetLaunch() {
    HomeWidget.initiallyLaunchedFromHomeWidget().then(_launchedFromWidget);
  }

  void _launchedFromWidget(Uri? uri) {
    if (uri != null) {
      showDialog(
        context: context,
        builder: (buildContext) => AlertDialog(
          title: const Text('App started from HomeScreenWidget'),
          content: Text('Here is the URI: $uri'),
        ),
      );
    }
  }

  // void _startBackgroundUpdate() {
  //   Workmanager().registerPeriodicTask(
  //     '1',
  //     'widgetBackgroundUpdate',
  //     frequency: const Duration(minutes: 15),
  //   );
  // }

  // void _stopBackgroundUpdate() {
  //   Workmanager().cancelByUniqueName('1');
  // }

  // Future<void> _getInstalledWidgets() async {
  //   try {
  //     final widgets = await HomeWidget.getInstalledWidgets();
  //     if (!mounted) return;

  //     String getText(HomeWidgetInfo widget) {
  //       if (Platform.isIOS) {
  //         return 'iOS Family: ${widget.iOSFamily}, iOS Kind: ${widget.iOSKind}';
  //       } else {
  //         return 'Android Widget id: ${widget.androidWidgetId}, '
  //             'Android Class Name: ${widget.androidClassName}, '
  //             'Android Label: ${widget.androidLabel}';
  //       }
  //     }

  //     await showDialog(
  //       context: context,
  //       builder: (buildContext) => AlertDialog(
  //         title: const Text('Installed Widgets'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Text('Number of widgets: ${widgets.length}'),
  //             const Divider(),
  //             for (final widget in widgets)
  //               Text(
  //                 getText(widget),
  //               ),
  //           ],
  //         ),
  //       ),
  //     );
  //   } on PlatformException catch (exception) {
  //     debugPrint('Error getting widget information. $exception');
  //   }
  // }

  Future<void> _checkPinability() async {
    final isRequestPinWidgetSupported = await HomeWidget.isRequestPinWidgetSupported();
    if (mounted) {
      setState(() {
        _isRequestPinWidgetSupported = isRequestPinWidgetSupported ?? false;
      });
    }
    debugPrint('isRequestPinWidgetSupported: $isRequestPinWidgetSupported');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeWidget Example'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // ElevatedButton(
              //   onPressed: _sendAndUpdate,
              //   child: const Text('Send Data to Widget'),
              // ),
              // ElevatedButton(
              //   onPressed: _checkForWidgetLaunch,
              //   child: const Text('Check For Widget Launch'),
              // ),
              // if (Platform.isAndroid)
              //   ElevatedButton(
              //     onPressed: _startBackgroundUpdate,
              //     child: const Text('Update in background'),
              //   ),
              // if (Platform.isAndroid)
              //   ElevatedButton(
              //     onPressed: _stopBackgroundUpdate,
              //     child: const Text('Stop updating in background'),
              //   ),
              // ElevatedButton(
              //   onPressed: _getInstalledWidgets,
              //   child: const Text('Get Installed Widgets'),
              // ),
              if (_isRequestPinWidgetSupported)
                ElevatedButton(
                  onPressed: () {
//                     HomeWidget.saveWidgetData('hijri_date', "1446 Rajab 12");
//                     HomeWidget.saveWidgetData('current_date', "12 - Jan - 2025");

//                     HomeWidget.saveWidgetData('fajar_prayer_name', "Fajr");
//                     HomeWidget.saveWidgetData('fajar_prayer_time', "05:00 AM");

//                     HomeWidget.saveWidgetData('dhuhr_prayer_name', "Dhuhr");
//                     HomeWidget.saveWidgetData('dhuhr_prayer_time', "12:30 PM");

//                     HomeWidget.saveWidgetData('asar_prayer_name', "Asar");
//                     HomeWidget.saveWidgetData('asar_prayer_time', "03:45 PM");

//                     HomeWidget.saveWidgetData('maghrib_prayer_name', "Maghrib");
//                     HomeWidget.saveWidgetData('maghrib_prayer_time', "06:15 PM");

//                     HomeWidget.saveWidgetData('isha_prayer_name', "Isha");
//                     HomeWidget.saveWidgetData('isha_prayer_time', "07:30 PM");

//                     HomeWidget.saveWidgetData('hijri_date', "1446 رجب 12");
//                     HomeWidget.saveWidgetData('current_date', "12 - يناير - 2025");

//                     HomeWidget.saveWidgetData('fajar_prayer_name', "الفجر");
//                     HomeWidget.saveWidgetData('fajar_prayer_time', "05:00 ");

//                     HomeWidget.saveWidgetData('dhuhr_prayer_name', "الظهر");
//                     HomeWidget.saveWidgetData('dhuhr_prayer_time', "12:30 ");

//                     HomeWidget.saveWidgetData('asar_prayer_name', "العصر");
//                     HomeWidget.saveWidgetData('asar_prayer_time', "03:45 ");

//                     HomeWidget.saveWidgetData('maghrib_prayer_name', "المغرب");
//                     HomeWidget.saveWidgetData('maghrib_prayer_time', "06:15 ");

//                     HomeWidget.saveWidgetData('isha_prayer_name', "العشاء");
//                     HomeWidget.saveWidgetData('isha_prayer_time', "07:30 ");

//                     HomeWidget.updateWidget(
//                       qualifiedAndroidName: 'com.example.appwidget.PrayerLargeSize',
//                       name: 'PrayerLargeSize',
//                     );
                    HomeWidget.saveWidgetData("current_prayer_name", 'Maghrib');
                    HomeWidget.saveWidgetData("current_prayer_time_format", 'PM');
                    HomeWidget.saveWidgetData("current_prayer_time", "06:04");
                    HomeWidget.updateWidget(
                      qualifiedAndroidName: 'com.example.appwidget.CurrentPrayerTime',
                      name: 'CurrentPrayerTime',
                    );

// Update current prayer details Today Date and Time
                    HomeWidget.saveWidgetData("current_prayer_name", "Fajr");
                    HomeWidget.saveWidgetData("current_prayer_time", "05:00");
                    HomeWidget.saveWidgetData("Tcurrent_date", "Saturday - 12 October, 2024");
                    HomeWidget.saveWidgetData("hijri_date", "Rabiʻ II 7, 1446 AH");
                    HomeWidget.saveWidgetData("next_prayer_time_first", "12:30");
                    HomeWidget.saveWidgetData("next_prayer_time_second", "15:45");
                    HomeWidget.saveWidgetData("current_prayer_time_format", "AM");
                    HomeWidget.saveWidgetData("next_prayer_time_format_first", "PM");
                    HomeWidget.saveWidgetData("next_prayer_time_format_second", "PM");
                    HomeWidget.saveWidgetData("current_location", "Makkah, Saudi Arabia");

                    HomeWidget.updateWidget(
                      qualifiedAndroidName: 'com.example.appwidget.TodayDateTimeWidget',
                      name: 'TodayDateTimeWidget',
                    );

// // Today Fasting Time Sheri and iftari Widget Work and Widget Name is
                    HomeWidget.saveWidgetData('modren_sehri_Time', "00:00");

                    HomeWidget.saveWidgetData('modren_sehritime_formate', "AM");
                    HomeWidget.saveWidgetData('modren_iftar_time', "02:12");
                    HomeWidget.saveWidgetData('modren_iftaritime_formate', "PM");

                    HomeWidget.updateWidget(
                      qualifiedAndroidName: 'com.example.appwidget.RamzanAppWidget',
                      name: 'RamzanAppWidget',
                    );

                    // Today Fasting Time Widget Work and Widget Name is
                    HomeWidget.saveWidgetData('current_date', "Ramadan Day 29");
                    HomeWidget.saveWidgetData('sehri_Time', "6:00");
                    HomeWidget.saveWidgetData('sehritime_formate', "AM");
                    HomeWidget.saveWidgetData('iftar_time', "6:58");
                    HomeWidget.saveWidgetData('iftaritime_formate', "PM");

                    HomeWidget.updateWidget(
                      qualifiedAndroidName: 'com.example.appwidget.RamzanSecondCard',
                      name: 'RamzanSecondCard',
                    );
                  },
                  child: const Text('Save and Update Widget'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
