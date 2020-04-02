import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:isolationhero/core/base/base_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:isolationhero/core/models/constants.dart';
import 'package:isolationhero/core/models/user_location.dart';
import 'package:isolationhero/core/services/secure_store.dart';

class LocationSetupViewModel extends BaseViewModel {
  LocationSetupViewModel();
  Position _position;
  String _address;
  UserLocation _userLocation;

  Position get position => this._position;
  String get address => this._address;
  UserLocation get userLocation => this._userLocation;

  set setPosition(Position position) {
    this._position = position;
    notifyListeners();
  }

  set setAddress(String address) {
    this._address = address;
    notifyListeners();
  }

  set setUserLocation(UserLocation userLocation) {
    this._userLocation = userLocation;
    notifyListeners();
  }

  void getLocation() async {
    await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((onValue) {
      setPosition = onValue;
      getLocationName(onValue);
    });
  }

  void getLocationName(Position position) async {
    final response = await http.get(
        "https://nominatim.openstreetmap.org/reverse?format=json&lat=" +
            position.latitude.toString() +
            "&lon=" +
            position.longitude.toString() +
            "&zoom=18&addressdetails=1");

    if (response.statusCode == 200) {
      var tagObjJson = json.decode(response.body);
      if (tagObjJson != null) {
        UserLocation userLocation = UserLocation.fromJson(tagObjJson);
        setAddress = userLocation.displayName.toString();
        setUserLocation = userLocation;
      }
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<bool> setLocation(UserLocation userLocation) async {
    bool result = false;
    SecuredStorage securedStorage = SecuredStorage.instance;

    String token= await securedStorage.readValue("token");
    String userId = await securedStorage.readValue("user_id");

    var body = {
      "lattitude": userLocation.lat.toString(),
      "longitude": userLocation.lon.toString(),
      "city_name": userLocation.address.city != null
          ? userLocation.address.city
          : userLocation.address.town,
      "state_name": userLocation.address.state,
      "country_name": userLocation.address.country,
      "zip_code": userLocation.address.postcode,
      "is_default": "1",
      "user": userId
    };

    await http
        .post(API_BASE_URL + '/api/userisolationlocation/', body: body)
        .then((response) {
      if (response.statusCode == 201) {
        result = true;
      } else {
        result = false;
      }
    });
    return result;
  }
}
