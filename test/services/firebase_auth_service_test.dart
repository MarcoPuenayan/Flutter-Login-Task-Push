import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_login/service/firebase_auth_service.dart';

import 'firebase_auth_service_test.mocks.dart';

@GenerateMocks([FirebaseAuth, UserCredential, User])
void main() {
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;

  late MockFirebaseAuth mockFirebaseAuth;
  late FirebaseAuthService firebaseAuthService;

  final email = "test@test.com";
  final password = "password";
  final userId = "123";

  setUp(() {
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();

    mockFirebaseAuth = MockFirebaseAuth();
    firebaseAuthService = FirebaseAuthService(mockFirebaseAuth);
  });

  test(
    'Login returns AuthUser when signInWithEmailAndPassword successful',
    () async {
      // Mock user credentials returned by FirebaseAuth
      when(mockUserCredential.user).thenReturn(mockUser);
      when(mockUser.email).thenReturn(email);
      when(mockUser.uid).thenReturn(userId);

      when(
        mockFirebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        ),
      ).thenAnswer((_) async => mockUserCredential);

      final result = await firebaseAuthService.login(email, password);

      expect(result, isNotNull);
      expect(result?.emailAddress, email);
      expect(result?.userId, userId);
    },
  );

  test('Login returns null when signInWithEmailAndPassword fails', () async {
    when(
      mockFirebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ),
    ).thenThrow(FirebaseAuthException(code: 'invalid-credential'));

    final result = await firebaseAuthService.login(email, password);

    expect(result, isNull);
  });
}
