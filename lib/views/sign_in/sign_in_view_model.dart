import 'dart:convert';

import 'package:isolationhero/core/base/base_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:isolationhero/core/models/auth_user.dart';
import 'package:isolationhero/core/services/secure_store.dart';

class SignInViewModel extends BaseViewModel {


  SignInViewModel();

  Future<bool> login(String userName, String email, String password) async {
    bool result = false;
    var body = {"email": email, "password": password};

    await http
        .post('http://isolationhero.vishleshak.io/users/rest-auth/login/',
            body: body)
        .then((response) {
      if (response.statusCode == 200) {
        AuthUser authUser = AuthUser.fromJson(json.decode(response.body));
        SecuredStorage securedStorage = SecuredStorage.instance;
        securedStorage.insertValue("token", authUser.token);
        result = true;
      } else {
        result = false;
      }
    });
    return result;
  }
}
