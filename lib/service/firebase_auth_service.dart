import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_login/models/auth_user.dart';
import 'package:flutter_firebase_login/service/interfaces/auth_service.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthService(this._firebaseAuth);

  late AuthUser _currentAuthUser;

  @override
  Future<AuthUser?> login(String email, String password) async {
    try {
      final credentials = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _currentAuthUser = AuthUser(
        emailAddress: credentials.user?.email,
        userId: credentials.user?.uid,
      );

      return _currentAuthUser;
    } catch (e) {
      return null;
    }
  }

  @override
  AuthUser getCurrentUser() {
    return _currentAuthUser;
  }

  @override
  Future<void> logout() async {
    _firebaseAuth.signOut();
  }
}
