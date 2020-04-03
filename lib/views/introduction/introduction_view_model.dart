import 'package:isolationhero/core/base/base_view_model.dart';
import 'package:isolationhero/core/models/constants.dart';
import 'package:isolationhero/core/models/setting.dart';
import 'package:isolationhero/core/services/database_helper.dart';
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
      DatabaseHelper helper = DatabaseHelper.instance;
      helper.insert(Setting("introduction_viewed_by_user", 1));
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
    print(API_BASE_URL + '/users/api-token-verify/');
    await http
        .post(API_BASE_URL + '/users/api-token-verify/', body: body)
        .then((response) {
      if (response.statusCode == 200) {
        result = true;
      } else {
        result = false;
      }
    });
    return result;
  }

  Future<bool> isIntroductionSeenByUser() async {
    bool result = false;
    DatabaseHelper helper = DatabaseHelper.instance;
    await helper.querySetting("introduction_viewed_by_user").then((onValue) {
      if (onValue != null) {
        result = onValue.value == 1;
        setIsIntroSeen = onValue.value == 1;
      }
    });
    return result;
  }

  bool isUserLoggedIn() {
    DatabaseHelper helper = DatabaseHelper.instance;
    helper.querySetting("user_logged_in").then((onValue) {
      if (onValue != null) {
        return onValue.value;
      }
      return false;
    });
    return false;
  }
}
