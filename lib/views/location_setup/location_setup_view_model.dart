import 'package:geolocator/geolocator.dart';
import 'package:isolationhero/core/base/base_view_model.dart';

class LocationSetupViewModel extends BaseViewModel {
  LocationSetupViewModel();
  Position _position;

  Position get position => this._position;

  set setPosition(Position position) {
    this._position = position;
    notifyListeners();
  }

  void getLocation() async {
    await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((onValue) {
      setPosition = onValue;
    });
  }
}
