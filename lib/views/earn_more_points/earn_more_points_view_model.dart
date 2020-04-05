import 'dart:convert';

import 'package:isolationhero/core/base/base_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:isolationhero/core/models/bonus_point_link.dart';
import 'package:isolationhero/core/models/constants.dart';
import 'package:isolationhero/core/services/secure_store.dart';

class EarnMorePointsViewModel extends BaseViewModel {
  EarnMorePointsViewModel();

  List<BonusPointLink> _bonusPointLinks;
  bool _noDataFound;

  List<BonusPointLink> get bonusPointLinks => this._bonusPointLinks;
  bool get noDataFound => this._noDataFound;

  set setBonusPointLinks(List<BonusPointLink> bonusPointLinks) {
    this._bonusPointLinks = bonusPointLinks;
    notifyListeners();
  }

  set setNoDataFound(bool noDataFound) {
    this._noDataFound = noDataFound;
    notifyListeners();
  }

  void getBonusPointLinks() async {
    SecuredStorage securedStorage = SecuredStorage.instance;
    String userId = await securedStorage.readValue("user_id");

    final response = await http
        .get(API_BASE_URL + '/api/activebonuspointlink/' + userId + "/");

    if (response.statusCode == 200) {
      var tagObjsJson = json.decode(response.body) as List;
      setBonusPointLinks = tagObjsJson
          .map((tagJson) => BonusPointLink.fromJson(tagJson))
          .toList();
      setNoDataFound = false;
    }
    if (response.statusCode == 404) {
      setNoDataFound = true;
    }
  }

  Future<bool> setLinkClickedByUser(String linkId) async {
    bool result = false;

    SecuredStorage securedStorage = SecuredStorage.instance;
    String userId = await securedStorage.readValue("user_id");

    var body = {"user": userId, "bonus_point_link": linkId};

    final response =
        await http.post(API_BASE_URL + '/api/uservisitbonuspoint/', body: body);

    if (response.statusCode == 200) {
      result = true;
      getBonusPointLinks();
    } else {
      result = false;
    }
    return result;
  }
}
