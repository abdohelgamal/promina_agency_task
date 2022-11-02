abstract class AuthAbstractState {}

class AuthInitialState extends AuthAbstractState {}

class AuthLoadingState extends AuthAbstractState {}

class AuthErrorState extends AuthAbstractState {
  final String message;
  AuthErrorState(this.message);
}

class AuthSuccessState extends AuthAbstractState {}
