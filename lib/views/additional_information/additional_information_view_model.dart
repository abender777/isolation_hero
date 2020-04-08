import 'package:isolationhero/core/base/base_view_model.dart';
import 'package:isolationhero/core/models/constants.dart';
import 'package:isolationhero/core/services/secure_store.dart';
import 'package:http/http.dart' as http;

class AdditionalInformationViewModel extends BaseViewModel {
  AdditionalInformationViewModel();

  Future<bool> saveUserProfile(
      String userName, String age, String gender) async {
    bool result = false;
    SecuredStorage securedStorage = SecuredStorage.instance;
    String userId = await securedStorage.readValue("user_id");

    var body = {"user": userId, "age": age, "gender": gender};

    final response =
        await http.post(API_BASE_URL + '/api/userprofile/', body: body);

    if (response.statusCode == 200) {
      result = true;
    }
    return result;
  }
}
