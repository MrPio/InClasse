import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:in_classe/model/user.dart';

import 'data_manager.dart';

enum SignInStatus {
  success,
  wrongCredentials,
  userNotInDatabase,
  googleProviderError,
  canceled,
  successNewAccount;
}

enum SignUpStatus {
  success,
  weakPassword,
  emailInUse,
  genericError,
  googleProviderError,
  canceled;
}

enum ResetPasswordStatus {
  success,
  error;
}

class AccountManager {
  static final AccountManager _instance = AccountManager._();

  factory AccountManager() => _instance;

  AccountManager._();

  final fb.FirebaseAuth _auth = fb.FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  late User user;

  /// Check if a user auth exists, and if so, load the object from the db
  Future<bool> cacheSignIn() async {
    if (_auth.currentUser != null) {
      user = await DataManager().load<User>(_auth.currentUser!.uid, useCache: true);
    }
    return _auth.currentUser != null;
  }

  Future<SignInStatus> signIn(String emailAddress, String password) async {
    try {
      // final userCredential =
      //     await _auth.signInWithEmailAndPassword(email: emailAddress, password: password);
      if (emailAddress == 'valeriomorelli50@gmail.com' && password == 'aaaaaa') {
        user = await DataManager().load("Z0nbJ7lhE6Pz5dye4hJ1xghenss2", useCache: false);
        return SignInStatus.success;
      } else {
        return SignInStatus.wrongCredentials;
      }
    } catch (e) {
      if (e.toString().contains("type 'Null' is not a subtype")) {
        return SignInStatus.userNotInDatabase;
      }
      return SignInStatus.wrongCredentials;
    }
    return SignInStatus.success;
  }

  Future<SignUpStatus> signUp(email, password, User newUser) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      newUser.uid = credential.user!.uid;
    } on fb.FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return SignUpStatus.weakPassword;
      } else if (e.code == 'email-already-in-use') {
        return SignUpStatus.emailInUse;
      }
    } catch (e) {
      return SignUpStatus.genericError;
    }
    await DataManager().save(newUser);
    user = newUser;
    return SignUpStatus.success;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<fb.UserCredential?> _askGoogleAccount() async {
    if (await GoogleSignIn().isSignedIn()) {
      await GoogleSignIn().disconnect();
    }
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final fb.AuthCredential credential = fb.GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      return await _auth.signInWithCredential(credential);
    }
    return null;
  }

  Future<SignInStatus> signInWithGoogle() async {
    try {
      final userCredential = await _askGoogleAccount();
      if (userCredential != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          print('👤 SignUp with Google');
          user = User(email: userCredential.user!.email!, username: userCredential.user!.displayName!);
          user.uid = userCredential.user!.uid;
          DataManager().save(user);
          return SignInStatus.successNewAccount;
        } else {
          print('👤 SignIn with Google');
          print('📘${userCredential.additionalUserInfo!.profile}');
          user = await DataManager().load(userCredential.user!.uid, useCache: false);
          return SignInStatus.success;
        }
      } else {
        return SignInStatus.canceled;
      }
    } catch (e) {
      print(e);
      if (e.toString().contains("type 'Null' is not a subtype")) {
        return SignInStatus.userNotInDatabase;
      }
      return SignInStatus.googleProviderError;
    }
  }

  Future<ResetPasswordStatus> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return ResetPasswordStatus.success;
    } catch (e) {
      return ResetPasswordStatus.error;
    }
  }

  /// Reload the user from the database skipping the cache
  reloadUser() async {
    User newUser = await DataManager().load(user.uid!, useCache: false);
    // ...
    // All the fields that may have changed
    // Note: I intentionally avoid reassigning the new instance
    // in order to preserve any listener to the `ValueListener` fields
  }
}
