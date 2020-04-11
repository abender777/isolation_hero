import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:isolationhero/core/locator.dart';
import 'package:isolationhero/core/models/constants.dart';
import 'package:isolationhero/core/services/secure_store.dart';
import 'package:isolationhero/theme/app_theme.dart';
import 'package:isolationhero/views/introduction/introduction_view.dart';
import 'core/services/navigator_service.dart';
import 'package:http/http.dart' as http;
import 'package:workmanager/workmanager.dart' as workManager;
import 'package:alice/alice.dart';

/// This "Headless Task" is run when app is terminated.
// void backgroundFetchHeadlessTask(String taskId) async {
//   _saveLocation();
//   BackgroundFetch.finish(taskId);
//   BackgroundFetch.scheduleTask(TaskConfig(
//       taskId: "com.isolationhero.customtask",
//       delay: 5000,
//       periodic: false,
//       forceAlarmManager: true,
//       stopOnTerminate: false,
//       enableHeadless: true));
// }
int counter = 0;
void initWorkManager() {
  workManager.Workmanager.executeTask((task, inputData) {
    _saveLocation(); //simpleTask will be emitted here.
     counter = counter++;
    print("Native called background task: $task, $counter");
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocatorInjector.setupLocator();
  runApp(new MyApp());
  SecuredStorage securedStorage = SecuredStorage.instance;
  await securedStorage.insertValue(
      "histoy_url", API_BASE_URL + '/api/userlocationhistory/');
  _saveLocation();
  //BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
  //PushMessaging().initState();
}

void _saveLocation() async {
  var alice = Alice(showNotification: true, darkTheme: true);
  SecuredStorage securedStorage = SecuredStorage.instance;
  final userId = await securedStorage.readValue("user_id");
  final url = await securedStorage.readValue("histoy_url");
  Position location = await Geolocator().getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      locationPermissionLevel: GeolocationPermission.locationAlways);
    var body = {
      "lattitude": location != null ? location.latitude.toString() : -37.81384,
      "longitude": location != null ?  location.longitude.toString() : 144.963028,
      "user": userId != null ? userId.toString() : "33"
    };
    http.post(url, body: body).then((response) {
      alice.onHttpResponse(response);
    });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

enum _Platform { android, ios }

class PlatformEnabledButton extends RaisedButton {
  final _Platform platform;

  PlatformEnabledButton({
    this.platform,
    @required Widget child,
    @required VoidCallback onPressed,
  })  : assert(child != null, onPressed != null),
        super(
            child: child,
            onPressed: (Platform.isAndroid && platform == _Platform.android ||
                    Platform.isIOS && platform == _Platform.ios)
                ? onPressed
                : null);
}

class _MyAppState extends State<MyApp> {
  final String backgroundTaskId = "isolocationtask0";
  final String backgroundTaskTag = "isolocation";

  @override
  void initState() {
    workManager.Workmanager.initialize(initWorkManager, isInDebugMode: true);
    workManager.Workmanager.registerPeriodicTask("$backgroundTaskId$counter",
        "isolocationClientLocationTracking-0$counter",
        tag: backgroundTaskTag,
        frequency: Duration(minutes: 15),
        existingWorkPolicy: workManager.ExistingWorkPolicy.keep,
        backoffPolicy: workManager.BackoffPolicy.linear,
        constraints: workManager.Constraints(
          networkType: workManager.NetworkType.connected,
        ));
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initPlatformState() async {
  //   // Configure BackgroundFetch.
  //   BackgroundFetch.configure(
  //       BackgroundFetchConfig(
  //           minimumFetchInterval: 15,
  //           stopOnTerminate: false,
  //           enableHeadless: true,
  //           requiresBatteryNotLow: false,
  //           requiresCharging: false,
  //           requiresStorageNotLow: false,
  //           requiresDeviceIdle: false), (String taskId) async {
  //     // This is the fetch-event callback.
  //     print("[BackgroundFetch] Event received $taskId");
  //     _saveLocation();
  //     BackgroundFetch.finish(taskId);
  //   }).then((int status) {
  //     print('[BackgroundFetch] configure success: $status');
  //   }).catchError((e) {
  //     print('[BackgroundFetch] configure ERROR: $e');
  //   });

  //   BackgroundFetch.scheduleTask(TaskConfig(
  //       taskId: "com.isolationhero.customtask",
  //       delay: 10000,
  //       periodic: false,
  //       forceAlarmManager: true,
  //       stopOnTerminate: false,
  //       enableHeadless: true
  //   ));

  // If the widget was removed from the tree while the asynchronous platform
  // message was in flight, we want to discard the reply rather than calling
  // setState to update our non-existent appearance.
  //   if (!mounted) return;
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        navigatorKey: locator<NavigatorService>().navigatorKey,
        home: IntroductionView());
  }
}
