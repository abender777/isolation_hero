import 'dart:convert';

import 'package:isolationhero/core/base/base_view_model.dart';
import 'package:isolationhero/core/models/constants.dart';
import 'package:isolationhero/core/models/leaderboard.dart';
import 'package:http/http.dart' as http;

class LeaderboardViewModel extends BaseViewModel {
  LeaderboardViewModel();

  List<Leaderboard> _leaderboards;

  List<Leaderboard> get leaderboards => this._leaderboards;

  set setLearderbords(List<Leaderboard> leaderboards) {
    this._leaderboards = leaderboards;
    notifyListeners();
  }

  void getLeaderboard(String level) async {

    final response =
        await http.get(API_BASE_URL + '/api/leaderboard/' + level + "/");

    if (response.statusCode == 200) {
      var tagObjsJson = json.decode(response.body)['results'] as List;
      setLearderbords =
          tagObjsJson.map((tagJson) => Leaderboard.fromJson(tagJson)).toList();
    }
  }
}
