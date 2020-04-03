import 'dart:convert';

import 'package:isolationhero/core/base/base_view_model.dart';
import 'package:isolationhero/core/models/constants.dart';
import 'package:isolationhero/core/models/daily_stat.dart';
import 'package:isolationhero/core/models/user_stat.dart';
import 'package:http/http.dart' as http;
import 'package:isolationhero/core/services/secure_store.dart';

class MyLeaderboardViewModel extends BaseViewModel {
  MyLeaderboardViewModel();

  List<UserStat> _userStats;
  List<UserDailyStat> _userDailyStats;

  List<UserStat> get userStats => this._userStats;
  List<UserDailyStat> get userDailyStats => this._userDailyStats;

  set setUserStats(List<UserStat> userStats) {
    this._userStats = userStats;
    notifyListeners();
  }

  set setUserDailyStats(List<UserDailyStat> userDailyStats) {
    this._userDailyStats = userDailyStats;
    notifyListeners();
  }

  void getUserStats() async {
    SecuredStorage securedStorage = SecuredStorage.instance;
    String userId = await securedStorage.readValue("user_id");

    final response =
        await http.get(API_BASE_URL + '/api/userscore/' + userId + '/');

    if (response.statusCode == 200) {
      var tagObjsJson = json.decode(response.body);

      List<UserStat> learderbordStats = new List<UserStat>();
      learderbordStats.add(new UserStat(
          name: "points",
          count: tagObjsJson["points"] != null
              ? tagObjsJson["points"].toString()
              : "0"));
      learderbordStats.add(new UserStat(
          name: "level",
          count: tagObjsJson["level"] != null
              ? tagObjsJson["level"].toString()
              : "0"));
      setUserStats = learderbordStats;
    }
  }

  void getUserDailyStats() async {
    SecuredStorage securedStorage = SecuredStorage.instance;
    String userId = await securedStorage.readValue("user_id");

    final response =
        await http.get(API_BASE_URL + '/api/userdailystatlist/' + userId + '/');

    if (response.statusCode == 200) {
      var tagObjsJson = json.decode(response.body)['results'] as List;
      setUserDailyStats = tagObjsJson
          .map((tagJson) => UserDailyStat.fromJson(tagJson))
          .toList();
    }
  }
}
