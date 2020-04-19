import '../core/logger.dart';
import '../core/services/navigator_service.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:isolationhero/core/services/secure_store.dart';
import 'package:location/location.dart';
import 'package:isolationhero/core/models/constants.dart';
import 'package:http/http.dart' as http;

GetIt locator = GetIt.instance;

class LocatorInjector {
  static Logger _log = getLogger('LocatorInjector');

  static Future<void> setupLocator() async {
    _log.d('Initializing Navigator Service');
    locator.registerLazySingleton(() => NavigatorService());
  }

  static Future<void> saveLocation() async {
    SecuredStorage securedStorage = SecuredStorage.instance;
    final userId = securedStorage.readValue("user_id");

    Location location = new Location();
    LocationData position = await location.getLocation();
    var body = {
      "lattitude": position.latitude != null
          ? position.latitude.toString()
          : "not_received",
      "longitude": position.longitude != null
          ? position.longitude.toString()
          : "not_received",
      "user": userId != null ? userId.toString() : "33"
    };
    http.post(API_BASE_URL + '/api/userlocationhistory/', body: body);
  }
}

