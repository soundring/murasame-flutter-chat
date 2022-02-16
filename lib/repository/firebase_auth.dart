// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuthService>(
    (_) => FirebaseAuthService(FirebaseAuth.instance));

class FirebaseAuthService {
  FirebaseAuthService(this._firebaseAuth);
  final FirebaseAuth _firebaseAuth;

  User getCurrentUser() {
    return _firebaseAuth.currentUser!;
  }

  Future<User> signInAnonymously() async {
    await _firebaseAuth.signInAnonymously();
    return getCurrentUser();
  }
}
