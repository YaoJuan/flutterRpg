import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rpg/models/app_user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FireAuthService {
  static final _instance = FirebaseAuth.instance;

  // login
  static Future<AppUser?> signIn(String email, String password) async {
    try {
      await _instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (_instance.currentUser == null) {
        return null;
      }
      return AppUser(
          uid: _instance.currentUser!.uid,
          email: _instance.currentUser!.email!);
    } catch (e) {
      return null;
    }
  }

  // Google signin InMobile
// Google signin InMobile
  static Future<AppUser?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authResult =
          await _instance.signInWithCredential(credential);
      saveCredentials(authResult);
      final User? user = authResult.user;

      if (user == null) {
        return null;
      }

      return AppUser(uid: user.uid, email: user.email!);
    } catch (error) {
      return null;
    }
  }

  // logout
  static Future<void> signOut() async {
    clearSavedCredentials();
    return await _instance.signOut();
  }

  // register
  static Future<AppUser?> signUp(String email, String password) async {
    try {
      final credential = await _instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      saveCredentials(credential);

      if (credential.user == null) {
        return null;
      }

      return AppUser(uid: credential.user!.uid, email: credential.user!.email!);
    } catch (error) {
      return null;
    }
  }

  static Stream<AppUser?> authStateChanges() {
    return _instance.authStateChanges().map((User? user) {
      if (user == null) {
        return null;
      } else {
        return AppUser(uid: user.uid, email: user.email!);
      }
    });
  }

  static Future<AppUser?> getCurrentUser() async {
    User? firebaseUser = _instance.currentUser;
    if (firebaseUser != null) {
      return AppUser(uid: firebaseUser.uid, email: firebaseUser.email!);
    } else {
      return null;
    }
  }

  static Future<AppUser?> signInWithSavedCredentials() async {
    String? refreshToken = await getSavedCredentials();
    if (refreshToken != null) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCustomToken(refreshToken);
        saveCredentials(userCredential);
        return AppUser(
            uid: userCredential.user!.uid, email: userCredential.user!.email!);
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<void> saveCredentials(UserCredential userCredential) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('refreshToken', userCredential.user!.refreshToken!);
  }

  // getSavedCredentials
  static Future<String?> getSavedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? refreshToken = prefs.getString('refreshToken');
    return refreshToken;
  }

  // clearSavedCredentials
  static Future<void> clearSavedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('refreshToken');
  }
}
