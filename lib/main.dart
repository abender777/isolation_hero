import 'dart:io';

import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:isolationhero/core/locator.dart';
import 'package:isolationhero/core/models/constants.dart';
import 'package:isolationhero/core/services/secure_store.dart';
import 'package:isolationhero/theme/app_theme.dart';
import 'package:isolationhero/views/introduction/introduction_view.dart';
import 'package:isolationhero/views/pushmessage.dart';
import 'package:isolationhero/views/sign_up/sign_up_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/services/navigator_service.dart';
import 'package:http/http.dart' as http;

/// This "Headless Task" is run when app is terminated.
void backgroundFetchHeadlessTask(String taskId) async {
  saveLocation();
  BackgroundFetch.finish(taskId);
  BackgroundFetch.scheduleTask(TaskConfig(
      taskId: "com.isolationhero.customtask",
      delay: 5000,
      periodic: false,
      forceAlarmManager: true,
      stopOnTerminate: false,
      enableHeadless: true));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocatorInjector.setupLocator();
  runApp(new MyApp());
 // BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

void saveLocation() async {
  SecuredStorage securedStorage = SecuredStorage.instance;
  final userId = await securedStorage.readValue("user_id");

  await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
      .then((onValue) {
    if (onValue != null) {
      var body = {
        "lattitude": onValue.latitude.toString(),
        "longitude": onValue.longitude.toString(),
        "user": userId != null ? userId.toString() : "0"
      };
      http.post(API_BASE_URL + '/api/userlocationhistory/', body: body);
    }
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

  @override
  void initState() {
    super.initState();
    initPlatformState();
    BackgroundFetch.start();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    BackgroundFetch.configure(
        BackgroundFetchConfig(
            minimumFetchInterval: 15,
            stopOnTerminate: false,
            enableHeadless: true,
            requiresBatteryNotLow: false,
            requiresCharging: false,
            requiresStorageNotLow: false,
            requiresDeviceIdle: false,
            requiredNetworkType: NetworkType.ANY), (String taskId) async {
      // This is the fetch-event callback.
      print("[BackgroundFetch] Event received $taskId");
      saveLocation();
      BackgroundFetch.finish(taskId);
    }).then((int status) {
      print('[BackgroundFetch] configure success: $status');
    }).catchError((e) {
      print('[BackgroundFetch] configure ERROR: $e');
    });

    BackgroundFetch.scheduleTask(TaskConfig(
        taskId: "com.isolationhero.customtask",
        delay: 10000,
        periodic: false,
        forceAlarmManager: true,
        stopOnTerminate: false,
        enableHeadless: true
    ));

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        navigatorKey: locator<NavigatorService>().navigatorKey,
        home: PushMessagingExample());
  }
}
