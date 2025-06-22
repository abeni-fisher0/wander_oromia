// logic/blocs/auth/auth_event.dart
abstract class AuthEvent {}

class AuthLogin extends AuthEvent {}

class AuthLogout extends AuthEvent {}
