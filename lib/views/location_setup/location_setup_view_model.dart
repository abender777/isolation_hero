import 'dart:convert';

import 'package:isolationhero/core/base/base_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:isolationhero/core/models/constants.dart';
import 'package:isolationhero/core/models/user_location.dart';
import 'package:isolationhero/core/services/secure_store.dart';
import 'package:location/location.dart';

class LocationSetupViewModel extends BaseViewModel {
  LocationSetupViewModel();
  LocationData _position;
  String _address;
  UserLocation _userLocation;

  LocationData get position => this._position;
  String get address => this._address;
  UserLocation get userLocation => this._userLocation;

  set setPosition(LocationData position) {
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
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

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
    _locationData = await location.getLocation();
    setPosition = _locationData;
    getLocationName(_locationData);
  }

  void getLocationName(LocationData location) async {
    final response = await http.get(
        "https://nominatim.openstreetmap.org/reverse?format=json&lat=" +
            location.latitude.toString() +
            "&lon=" +
            location.longitude.toString() +
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
    String userId = await securedStorage.readValue("user_id");

    var body = {
      "lattitude": userLocation.lat.toString(),
      "longitude": userLocation.lon.toString(),
      "city_name": userLocation.address.city != null
          ? userLocation.address.city
          : userLocation.address.town != null ? userLocation.address.town : userLocation.address.county != null ? userLocation.address.county : "",
      "state_name": userLocation.address.state != null ? userLocation.address.state : "",
      "country_name": userLocation.address.country != null ? userLocation.address.country : "",
      "zip_code": userLocation.address.postcode != null ? userLocation.address.postcode : "",
      "is_default": "1",
      "user": userId
    };

    await http
        .post(API_BASE_URL + '/api/userisolationlocation/', body: body)
        .then((response) {
      if (response.statusCode == 201) {
        result = true;
        addUserScore(userId);
      } else {
        result = false;
      }
    });
    return result;
  }

  Future<bool> addUserScore(String userId) async {
    bool result = false;

    SecuredStorage securedStorage = SecuredStorage.instance;
    String userId = await securedStorage.readValue("user_id");

    var body = {"user": userId, "points": "100", "level": "1"};

    await http
        .post(API_BASE_URL + '/api/userlevelscore/', body: body)
        .then((response) {
      if (response.statusCode == 200) {
        result = true;
      } else {
        result = false;
      }
    });
    return result;
  }

}
