import 'package:flutter_firebase_login/models/auth_user.dart';
import 'package:flutter_firebase_login/service/interfaces/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_firebase_login/bloc/user_auth_bloc.dart';
import 'package:mockito/annotations.dart';

import 'user_auth_bloc_test.mocks.dart';

@GenerateMocks([AuthService])
void main() {
  late MockAuthService mockAuthService;
  late UserAuthBloc userAuthBloc;

  final email = "test@test.com";
  final password = "password";

  setUp(() {
    mockAuthService = MockAuthService();
    userAuthBloc = UserAuthBloc(mockAuthService);
  });

  tearDown(() {
    userAuthBloc.dispose();
  });

  group("Login", () {
    test('Emits AuthUser on successful login', () async {
      final authUser = AuthUser(userId: "123", emailAddress: email);

      // Mocks login case where email and password are correct and returns the AuthUser data.
      when(
        mockAuthService.login(email, password),
      ).thenAnswer((_) async => authUser);
      when(mockAuthService.getCurrentUser()).thenAnswer((_) => authUser);

      expectLater(userAuthBloc.userAuthStream, emitsInOrder([authUser]));

      await userAuthBloc.login(email, password);
    });

    test('Emits error on failed login', () async {
      // Mocks login case where email and password are incorrect as required by the AuthService.
      when(
        mockAuthService.login(email, password),
      ).thenAnswer((_) async => null);

      expectLater(
        userAuthBloc.userAuthStream,
        emitsError("Invalid email or password"),
      );

      await userAuthBloc.login(email, password);
    });
  });

  test('Emits null on logout', () async {
    expectLater(userAuthBloc.userAuthStream, emits(null));

    await userAuthBloc.logout();
  });

  test('Fetches current auth user', () async {
    final authUser = AuthUser(userId: "123", emailAddress: email);

    when(mockAuthService.getCurrentUser()).thenReturn(authUser);

    expectLater(userAuthBloc.userAuthStream, emits(authUser));

    await userAuthBloc.fetchCurrentAuthUser();
  });
}
