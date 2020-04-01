import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:isolationhero/core/locator.dart';
import 'package:isolationhero/core/services/database_helper.dart';
import 'package:isolationhero/theme/app_theme.dart';
import 'package:isolationhero/views/introduction/introduction_view.dart';
import 'package:http/http.dart' as http;
import 'package:isolationhero/views/sign_up/sign_up_view.dart';
import 'core/services/navigator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocatorInjector.setupLocator();
  runApp(new MyApp());
}

void saveLocation(String id) async {
  await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
      .then((onValue) {
    if (onValue != null) {
      sendLocationToDatabase(
          id, onValue.latitude.toString(), onValue.longitude.toString());
    }
  });
}

Future<bool> sendLocationToDatabase(
    String userId, String lat, String long) async {
  var body = {"user_id": userId, "lat": lat, "long": long};

  await http
      .post('http://heroapis.vishleshak.io/api/v1/userlocation', body: body)
      .then((response) {
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  });
  return null;
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
  }

  @override
  Widget build(BuildContext context) {
    bool isIntroSeen = false;
    
    isIntroductionSeenByUser().then((onValue){
      isIntroSeen = onValue; 
    });
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      navigatorKey: locator<NavigatorService>().navigatorKey,
      home:  isIntroSeen ? SignUpView() : IntroductionView(),
    );
  }

  Future<bool> isIntroductionSeenByUser() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    await helper.querySetting("introduction_viewed_by_user").then((onValue) {
      if (onValue != null) {
        return onValue.value == 1;
      }
      return false;
    });
    return false;
  }

  bool isUserLoggedIn() {
    DatabaseHelper helper = DatabaseHelper.instance;
    helper.querySetting("user_logged_in").then((onValue) {
      if (onValue != null) {
        return onValue.value;
      }
      return false;
    });
    return false;
  }
}
