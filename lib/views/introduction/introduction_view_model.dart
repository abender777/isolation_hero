import 'dart:convert';

import 'package:isolationhero/core/base/base_view_model.dart';
import 'package:isolationhero/core/models/constants.dart';
import 'package:isolationhero/core/models/instruction.dart';
import 'package:isolationhero/core/services/secure_store.dart';
import 'package:http/http.dart' as http;

class IntroductionViewModel extends BaseViewModel {
  IntroductionViewModel();

  bool _isTokenValid;
  bool _isIntroSeen;
  bool _isolationLocationSet;

  bool get isTokenValid => this._isTokenValid;
  bool get isIntroSeen => this._isIntroSeen;
  bool get isolationLocationSet => this._isolationLocationSet;

  set setIsTokenValid(bool isTokenValid) {
    this._isTokenValid = isTokenValid;
    notifyListeners();
  }

  set setIsolationLocationSet(bool isolationLocationSet) {
    this._isolationLocationSet = isolationLocationSet;
    notifyListeners();
  }

  set setIsIntroSeen(bool isIntroSeen) {
    this._isIntroSeen = isIntroSeen;
    notifyListeners();
  }

  void setIntroductionComplete() async {
    try {
      SecuredStorage securedStorage = SecuredStorage.instance;
      await securedStorage.insertValue("intro-seen", "1");
    } catch (e) {
      print(e);
    }
  }

  void verifyUserToken() async {
    SecuredStorage securedStorage = SecuredStorage.instance;
    String userId = await securedStorage.readValue("user_id");
    if (userId != null || userId != "null") {
      setIsTokenValid = true;
    }
  }

  Future<bool> getUserIsolationLocation() async {
    bool result = false;
    SecuredStorage securedStorage = SecuredStorage.instance;
    String userId = await securedStorage.readValue("user_id");

    if (userId != null || userId != "null") {
      final response = await http
          .get(API_BASE_URL + '/api/isolationlocationbyuser/' + userId + '/');

      if (response.statusCode == 200) {
        setIsolationLocationSet = true;
        result = true;
      }
      if (response.statusCode == 404) {
        setIsolationLocationSet = false;
        result = false;
      }
    } else {
      setIsolationLocationSet = false;
    }
    return result;
  }

  Future<bool> verifyToken(String token) async {
    bool result = false;
    var body = {"token": token};

    final response =
        await http.post(API_BASE_URL + '/users/api-token-verify/', body: body);
    if (response.statusCode == 200) {
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  void isIntroductionSeenByUser() async {
    SecuredStorage securedStorage = SecuredStorage.instance;
    String introSeen = await securedStorage.readValue("intro-seen");
    if (introSeen == null || introSeen == "null") {
      setIsIntroSeen = false;
    }
    if (introSeen == "1") {
      setIsIntroSeen = true;
    }
  }

  List<Instruction> _instructions;

  List<Instruction> get instructions => this._instructions;

  set setInstructions(List<Instruction> instructions) {
    this._instructions = instructions;
    notifyListeners();
  }

  void getInstructions() async {
    final response = await http.get(API_BASE_URL + '/api/instruction/');

    if (response.statusCode == 200) {
      var tagObjsJson = json.decode(response.body)['results'] as List;
      setInstructions =
          tagObjsJson.map((tagJson) => Instruction.fromJson(tagJson)).toList();
    }
  }
}
