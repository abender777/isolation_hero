import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:isolationhero/core/locator.dart';
import 'package:isolationhero/core/services/database_helper.dart';
import 'package:isolationhero/theme/app_theme.dart';
import 'package:isolationhero/views/introduction/introduction_view.dart';
import 'package:isolationhero/views/loading/loading_view.dart';
import 'package:isolationhero/views/sign_up/sign_up_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/services/navigator_service.dart';

const EVENTS_KEY = "fetch_events";

/// This "Headless Task" is run when app is terminated.
void backgroundFetchHeadlessTask(String taskId) async {
  print("[BackgroundFetch] Headless event received: $taskId");
  DateTime timestamp = DateTime.now();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Read fetch_events from SharedPreferences
  List<String> events = [];
  String json = prefs.getString(EVENTS_KEY);
  if (json != null) {
    events = jsonDecode(json).cast<String>();
  }

  // Add new event.
  events.insert(0, "$taskId@$timestamp [Headless]");
  saveLocation(events, taskId, timestamp);
  // Persist fetch events in SharedPreferences
  prefs.setString(EVENTS_KEY, jsonEncode(events));

  BackgroundFetch.finish(taskId);

  if (taskId == 'flutter_background_fetch') {
    BackgroundFetch.scheduleTask(TaskConfig(
        taskId: "com.transistorsoft.customtask",
        delay: 5000,
        periodic: false,
        forceAlarmManager: true,
        stopOnTerminate: false,
        enableHeadless: true));
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocatorInjector.setupLocator();
  runApp(new MyApp());
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

void saveLocation(
    List<String> events, String taskId, DateTime timestamp) async {
  await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
      .then((onValue) {
    if (onValue != null) {
      events.insert(0,
          "$taskId@$timestamp@${onValue.longitude}@${onValue.longitude} [Headless]");
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
  bool isIntroSeen;
  Widget body;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        navigatorKey: locator<NavigatorService>().navigatorKey,
        home: IntroductionView());
  }
}
