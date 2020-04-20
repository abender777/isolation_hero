import 'dart:async';
import 'dart:io';

import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:isolationhero/core/locator.dart';
import 'package:isolationhero/core/services/secure_store.dart';
import 'package:isolationhero/theme/app_theme.dart';
import 'package:isolationhero/views/introduction/introduction_view.dart';
import 'package:isolationhero/views/pushmessage.dart';
import 'core/services/navigator_service.dart';
import 'package:http/http.dart' as http;

/// This "Headless Task" is run when app is terminated.
void backgroundFetchHeadlessTask(String taskId) async {
  _saveLocation();
  BackgroundFetch.finish(taskId);
  BackgroundFetch.scheduleTask(TaskConfig(
      taskId: "com.transistorsoft.customtask",
      delay: 900000,
      periodic: false,
      forceAlarmManager: true,
      stopOnTerminate: false,
      enableHeadless: true));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocatorInjector.setupLocator();
  runApp(new MyApp());
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
  _saveLocation();
  PushMessaging().initState();
}

void _saveLocation() async {
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }
    SecuredStorage securedStorage = SecuredStorage.instance;
    final userId = await securedStorage.readValue("user_id");
    LocationData locationData = await location.getLocation();
    var body = {
      "lattitude": locationData.latitude.toString(),
      "longitude": locationData.longitude.toString(),
      "user": userId.toString()
    };
    http.post('http://54.212.117.37/api/userlocationhistory/', body: body);
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
  int _status;

  void permissionChecker() async {
    Location location = new Location();
    PermissionStatus _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      await location.requestPermission();
    }
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _status = 0;
    BackgroundFetch.start().then((int status) {
      print('[BackgroundFetch] start success: $status');
    }).catchError((e) {
      print('[BackgroundFetch] start FAILURE: $e');
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    BackgroundFetch.configure(
            BackgroundFetchConfig(
              minimumFetchInterval: 15,
              forceAlarmManager: false,
              stopOnTerminate: false,
              startOnBoot: true,
              enableHeadless: true,
              requiresBatteryNotLow: false,
              requiresCharging: false,
              requiresStorageNotLow: false,
              requiresDeviceIdle: false,
              requiredNetworkType: NetworkType.ANY,
            ),
            _onBackgroundFetch)
        .then((int status) {
      print('[BackgroundFetch] configure success: $status');
      setState(() {
        _status = status;
      });
    }).catchError((e) {
      print('[BackgroundFetch] configure ERROR: $e');
      setState(() {
        _status = e;
      });
    });

    BackgroundFetch.scheduleTask(TaskConfig(
        taskId: "com.transistorsoft.customtask",
        delay: 900000,
        periodic: false,
        forceAlarmManager: true,
        stopOnTerminate: false,
        enableHeadless: true));

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  void _onBackgroundFetch(String taskId) async {
    _saveLocation();
    if (taskId == "flutter_background_fetch") {
      BackgroundFetch.scheduleTask(TaskConfig(
          taskId: "com.transistorsoft.customtask",
          delay: 900000,
          periodic: false,
          forceAlarmManager: true,
          stopOnTerminate: false,
          enableHeadless: true));
    }

    // IMPORTANT:  You must signal completion of your fetch task or the OS can punish your app
    // for taking too long in the background.
    BackgroundFetch.finish(taskId);
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
