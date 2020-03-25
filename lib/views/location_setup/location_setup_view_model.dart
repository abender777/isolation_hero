import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:isolationhero/core/base/base_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:isolationhero/core/models/user_location.dart';

class LocationSetupViewModel extends BaseViewModel {
  LocationSetupViewModel();
  Position _position;
  String _address;

  Position get position => this._position;
  String get address => this._address;

  set setPosition(Position position) {
    this._position = position;
    notifyListeners();
  }

  set setAddress(String address) {
    this._address = address;
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
      }
    } else {
      throw Exception('Failed to load post');
    }
  }
}
