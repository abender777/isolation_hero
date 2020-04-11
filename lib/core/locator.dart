import '../core/logger.dart';
import '../core/services/navigator_service.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:isolationhero/core/services/secure_store.dart';
import 'package:geolocator/geolocator.dart';
import 'package:isolationhero/core/models/constants.dart';
import 'package:http/http.dart' as http;

GetIt locator = GetIt.instance;

class LocatorInjector {
  static Logger _log = getLogger('LocatorInjector');

  static Future<void> setupLocator() async {
    _log.d('Initializing Navigator Service');
    locator.registerLazySingleton(() => NavigatorService());
  }
}

