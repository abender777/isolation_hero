import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:isolationhero/core/base/base_view_model.dart';
import 'package:isolationhero/core/models/auth_user.dart';
import 'package:isolationhero/core/models/constants.dart';
import 'package:isolationhero/core/models/setting.dart';
import 'package:isolationhero/core/services/database_helper.dart';
import 'package:http/http.dart' as http;
import 'package:isolationhero/core/services/secure_store.dart';

class SignUpViewModel extends BaseViewModel {
  SignUpViewModel();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<bool> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
    addLoginInfoInDatabase(user.displayName, user.photoUrl, user.email);
    return fetchAndSetUserId(
        user.email, user.displayName, user.photoUrl, "Google");
  }

  bool fetchAndSetUserId(
      String emailId, String displayName, String photoUrl, String method) {
    final body = {
      "display_name": displayName,
      "email_id": emailId,
      "photo_url": photoUrl,
      "signup_by": method
    };
    return true;
  }

  void addLoginInfoInDatabase(
      String displayName, String photoUrl, String email) async {
    try {
      if (displayName != null) {
        insertSetting("DisplayName", displayName);
      }
      if (photoUrl != null) {
        insertSetting("PhotoUrl", photoUrl);
      }
      if (email != null) {
        insertSetting("Email", email);
      }
    } catch (e) {
      print(e);
    }
  }

  void insertSetting(String settingName, Object settingValue) {
    DatabaseHelper helper = DatabaseHelper.instance;
    Setting settingDisplayName = Setting(settingName, settingValue);
    helper.insert(settingDisplayName);
  }

  Future<FirebaseUser> handleSignInEmail(String email, String password) async {
    AuthResult result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    final FirebaseUser user = result.user;

    assert(user != null);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await auth.currentUser();
    assert(user.uid == currentUser.uid);

    print('signInEmail succeeded: $user');

    return user;
  }

  Future<FirebaseUser> handleSignUp(email, password) async {
    AuthResult result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final FirebaseUser user = result.user;

    assert(user != null);
    assert(await user.getIdToken() != null);

    return user;
  }

  Future<bool> login(String email, String password) async {
    bool result = false;
    var body = {"email": email, "password": password};

    await http
        .post(API_BASE_URL + '/users/rest-auth/login/', body: body)
        .then((response) {
      if (response.statusCode == 200) {
        AuthUser authUser = AuthUser.fromJson(json.decode(response.body));
        SecuredStorage securedStorage = SecuredStorage.instance;
        securedStorage.insertValue("token", authUser.token);
        securedStorage.insertValue("user_id", authUser.user.pk.toString());
        result = true;
      } else {
        result = false;
      }
    });
    return result;
  }

  Future<bool> register(String userName, String email, String password) async {
    bool result = false;
    var body = {"email": email, "password1": password, "password2": password};
    await http
        .post(API_BASE_URL + '/users/rest-auth/registration/', body: body)
        .then((response) {
      if (response.statusCode == 201) {
        login(email, password);
        result = true;
      } else {
        result = false;
      }
    });
    return result;
  }
}
