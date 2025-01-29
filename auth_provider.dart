import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {  // Make sure this extends ChangeNotifier
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Get current user
  User? get user => _auth.currentUser;

  // Constructor
  AuthProvider() {
    _auth.authStateChanges().listen((User? user) {
      notifyListeners();
    });
  }

  // Sign in with Google
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      notifyListeners();
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      notifyListeners();
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}