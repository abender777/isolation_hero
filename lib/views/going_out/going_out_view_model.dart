import 'dart:convert';

import 'package:isolationhero/core/base/base_view_model.dart';
import 'package:isolationhero/core/models/back_in_time.dart';
import 'package:isolationhero/core/models/constants.dart';
import 'package:isolationhero/core/models/movement_reason.dart';
import 'package:http/http.dart' as http;
import 'package:isolationhero/core/services/secure_store.dart';

class GoingOutViewModel extends BaseViewModel {
  GoingOutViewModel();

  List<MovementReason> _movementReasons;

  List<BackInTime> _backInTime;

  List<MovementReason> get movementReasons => this._movementReasons;

  List<BackInTime> get backInTime => this._backInTime;

  set setMovementReasons(List<MovementReason> movementReasons) {
    this._movementReasons = movementReasons;
    notifyListeners();
  }

  set setBackInTime(List<BackInTime> backInTime) {
    this._backInTime = backInTime;
    notifyListeners();
  }

  void getMovementReasons() async {
    final response = await http.get(API_BASE_URL + '/api/movementreason/');
    alice.onHttpResponse(response);
    if (response.statusCode == 200) {
      var tagObjsJson = json.decode(response.body)['results'] as List;
      setMovementReasons = tagObjsJson
          .map((tagJson) => MovementReason.fromJson(tagJson))
          .toList();
    } else {
      throw Exception('Failed to load post');
    }
  }

  void getBackInTimes() async {
    List<BackInTime> backInTimes = new List<BackInTime>();
    backInTimes.add(BackInTime(name: "30 Minutes", timeInMinutes: 30));
    backInTimes.add(BackInTime(name: "1 Hour", timeInMinutes: 60));
    backInTimes.add(BackInTime(name: "1.5 Hours", timeInMinutes: 90));
    backInTimes.add(BackInTime(name: "2 Hours", timeInMinutes: 120));
    backInTimes.add(BackInTime(name: "3 Hours", timeInMinutes: 150));
    backInTimes.add(BackInTime(name: "3.5 Hours", timeInMinutes: 180));
    backInTimes.add(BackInTime(name: "4 Hours", timeInMinutes: 210));
    setBackInTime = backInTimes;
  }

  Future<bool> addMovementReason(
      String movementReason, int timeInMinutes) async {
    bool result = false;
    var startTime = DateTime.now();
    var endTime = startTime.add(Duration(minutes: timeInMinutes));
    SecuredStorage securedStorage = SecuredStorage.instance;
    String userId = await securedStorage.readValue("user_id");

    var body = {
      "movement_reason_id": movementReason,
      "start_time": startTime.toString(),
      "end_time": endTime.toString(),
      "user": userId
    };

    await http
        .post(API_BASE_URL + '/api/usermovement/', body: body)
        .then((response) {
      alice.onHttpResponse(response);
      if (response.statusCode == 201) {
        result = true;
      } else {
        result = false;
      }
    });
    return result;
  }
}
