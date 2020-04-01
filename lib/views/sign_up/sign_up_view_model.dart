import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:isolationhero/core/base/base_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:isolationhero/core/models/setting.dart';
import 'package:isolationhero/core/services/database_helper.dart';

class SignUpViewModel extends BaseViewModel {
  SignUpViewModel();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin facebookSignIn = new FacebookLogin();

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

  Future<bool> signInWithFacebook() async {
    final FacebookLoginResult result = await facebookSignIn.logIn(["email"]);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,birthday,hometown,picture&access_token=$token');
        final profile = json.decode(graphResponse.body);
        addLoginInfoInDatabase(profile['name'],
            profile['picture']['data']['url'], profile['email']);
        return fetchAndSetUserId(profile['email'], profile['name'],
            profile['picture']['data']['url'], "Facebook");
      case FacebookLoginStatus.cancelledByUser:
      //_showMessage('Login cancelled by the user.');
        return false;
      case FacebookLoginStatus.error:
        return false;
    }
    return false;
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
}
