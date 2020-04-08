import 'package:isolationhero/core/base/base_view_model.dart';
import 'package:isolationhero/core/models/constants.dart';
import 'package:isolationhero/core/services/secure_store.dart';
import 'package:http/http.dart' as http;

class IntroductionViewModel extends BaseViewModel {
  IntroductionViewModel();

  bool _isTokenValid;
  bool _isIntroSeen;

  bool get isTokenValid => this._isTokenValid;
  bool get isIntroSeen => this._isIntroSeen;

  set setIsTokenValid(bool isTokenValid) {
    this._isTokenValid = isTokenValid;
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
    String token = await securedStorage.readValue("token");
    bool isTokenValid = await verifyToken(token);
    setIsTokenValid = isTokenValid;
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
}
