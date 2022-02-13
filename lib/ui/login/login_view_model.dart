import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginViewModel extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void googleSignIn() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // If user cancels selection, throw error to prevent null check below.
      if (googleUser == null) {
        throw Exception('Must select a Google Account.');
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await _auth.signInWithCredential(credential);
    } catch (error) {
      debugPrint(error.toString());
      //TODO: Show error.
    }
  }

  void appleSignIn() async {
    try {
      // Trigger the authentication flow.
      final AuthorizationCredentialAppleID appleIdCredential =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Created credential from id credential.
      final OAuthCredential credential = OAuthProvider('apple.com').credential(
        idToken: appleIdCredential.identityToken!,
        accessToken: appleIdCredential.authorizationCode,
      );

      // Once signed in, return the UserCredential.
      await _auth.signInWithCredential(credential);
    } catch (error) {
      debugPrint(error.toString());
      //TODO: Show error.
    }
  }
}
