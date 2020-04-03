import 'dart:convert';

import 'package:isolationhero/core/base/base_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:isolationhero/core/models/auth_user.dart';
import 'package:isolationhero/core/models/constants.dart';
import 'package:isolationhero/core/services/secure_store.dart';

class SignInViewModel extends BaseViewModel {

  SignInViewModel();

  String _loginError;

  String get loginError => this._loginError;

  set setLoginError(String loginError) {
    this._loginError = loginError;
    //notifyListeners();
  }

  Future<bool> login(String userName, String email, String password) async {
    bool result = false;
    var body = {"email": email, "password": password};

    final response = await http
        .post(API_BASE_URL + '/users/rest-auth/login/',
            body: body);

      if (response.statusCode == 200) {
        AuthUser authUser = AuthUser.fromJson(json.decode(response.body));
        SecuredStorage securedStorage = SecuredStorage.instance;
        securedStorage.insertValue("token", authUser.token);
        securedStorage.insertValue("user_id", authUser.user.pk.toString());
        result = true;
      } 
      if (response.statusCode == 400) {
        var error = json.decode(response.body);
        if (error['non_field_errors'] != null) {
          setLoginError = error['non_field_errors'][0].toString();
        }
        result = false;
      }
    return result;
  }
}
