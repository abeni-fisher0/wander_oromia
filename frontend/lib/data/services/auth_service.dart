import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> signUp(String email, String password) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return cred.user?.getIdToken();
  }

  Future<String?> signIn(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return cred.user?.getIdToken();
  }

  Future<String?> getToken() async {
    return _auth.currentUser?.getIdToken();
  }

  Future<void> signOut() => _auth.signOut();

  bool isLoggedIn() => _auth.currentUser != null;
}
