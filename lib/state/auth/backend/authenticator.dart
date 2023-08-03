import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:insta_whisp/state/auth/constants/constants.dart';
import 'package:insta_whisp/state/auth/models/auth_result.dart';
import 'package:insta_whisp/state/constants/firestore_collection_names.dart';
import 'package:insta_whisp/state/constants/firestore_field_names.dart';
import 'package:insta_whisp/state/user_info/backend/user_info_storage.dart';
import 'package:insta_whisp/state/user_info/typedefs/user_id.dart';
import 'package:insta_whisp/utils/logger.dart';

@immutable
class Authenticator {
  User? get currentUser => FirebaseAuth.instance.currentUser;
  UserId? get userId => currentUser?.uid;
  bool get isAlreadyLoggedIn => userId != null;
  AuthResult get authResult {
    if (currentUser != null) {
      return AuthResult.success;
    } else {
      return AuthResult.failure;
    }
  }

  String get displayName => currentUser?.displayName ?? '';

  String get email => currentUser?.email ?? '';

  Future<bool> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      return true;
    } catch (_) {
      'Authenticator.logOut() function giving errors'.log();
      return false;
    }
  }

  Future<AuthResult> signInWithGoogle() async {
    try {
      '1'.log();
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [Constants.emailScope],
      );
      '2'.log();
      final googleSignInAccount = await googleSignIn.signIn();

      '3'.log();
      if (googleSignInAccount == null) {
        return AuthResult.aborted;
      }

      '4'.log();
      final signInAuth = await googleSignInAccount.authentication;

      '5'.log();
      final oauthCredentials = GoogleAuthProvider.credential(
        accessToken: signInAuth.accessToken,
        idToken: signInAuth.idToken,
      );
      ' before await FirebaseAuth.instance.signInWithCredential(oauthCredentials,);'
          .log();
      await FirebaseAuth.instance.signInWithCredential(
        oauthCredentials,
      );

      'successfully logged in'.log();
      return AuthResult.success;
    } catch (e) {
      'Authenticator.signInWithGoogle() function giving errors'.log();

      return AuthResult.failure;
    }
  }
}
