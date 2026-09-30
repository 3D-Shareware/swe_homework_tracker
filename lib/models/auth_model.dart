import "dart:js_interop";

import "package:firebase_auth/firebase_auth.dart";

class AuthModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> login(String email, String password) async {
    String defaultErrorMessage = "This is really awkward for the both of us. ";
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } // my custom code!
    on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-credential":
          return "Your email or password is incorrect. How unfortunate.";
        case "invalid-email":
          return "That is NOT what an email looks like. Try better.";
        // if I didn't account for it, then default that up!
        default:
          return (defaultErrorMessage + e.toString());
      }
    }
    // then we can default to traditional error printing if it ain't firebase auth
    catch (e) {
      return (defaultErrorMessage + e.toString());
    }
  }

  Future<String?> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;
}
