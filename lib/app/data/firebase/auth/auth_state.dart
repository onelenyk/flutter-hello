import "package:firebase_auth/firebase_auth.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:menyusha/app/data/firebase/user/user_payload.dart";

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  AuthState._();
  factory AuthState.authInitial(final bool loginOpened, final String email, final String password, ) = AuthInitial;

  factory AuthState.authSuccess(final User? user, final UserPayload? userPayload) = AuthSuccess;

  factory AuthState.authFailed(final String? error) = AuthFailed;

  factory AuthState.authLoading() = AuthLoading;

  factory AuthState.authSignedOut() = AuthSignedOut;

  String get login => getLogin();

  String getLogin() {
    var email = "";
    if (this is AuthSuccess) {
      email = (this as AuthSuccess).user?.email ?? "";
    } else {
      email = "";
    }
    return getLocalPartOfEmail(email);
  }

  String getLocalPartOfEmail(final String email) {
    // Check if the email contains '@' symbol
    if (email.contains('@')) {
      // Split the email by '@' and return the first part
      return email.split('@')[0];
    } else {
      // If email does not contain '@', return an empty string or handle as needed
      return '';
    }
  }
}


/*
sealed class AuthState {
  const AuthState._();

  // Factory constructors to create specific states
  factory AuthState.authInitial(bool loginOpened) = AuthInitial;
  factory AuthState.authSuccess(User? user) = AuthSuccess;
  factory AuthState.authFailed(String? error) = AuthFailed;
  factory AuthState.authLoading() = AuthLoading;
  factory AuthState.authSignedOut() = AuthSignedOut;


  // Shared methods
  String get login => getLogin();

  String getLogin() {
    var email = "";
    if (this is AuthSuccess) {
      email = (this as AuthSuccess).user?.email ?? "";
    } else {
      email = "";
    }
    return getLocalPartOfEmail(email);
  }

  String getLocalPartOfEmail(final String email) {
    if (email.contains('@')) {
      return email.split('@')[0];
    } else {
      return '';
    }
  }
}

// AuthState subclasses
class AuthInitial extends AuthState {
  final bool loginOpened;
  const AuthInitial(this.loginOpened) : super._();
}

class AuthSuccess extends AuthState {
  final User? user;
  const AuthSuccess(this.user) : super._();
}

class AuthFailed extends AuthState {
  final String? error;
  const AuthFailed(this.error) : super._();
}

class AuthLoading extends AuthState {
  const AuthLoading() : super._();
}

class AuthSignedOut extends AuthState {
  const AuthSignedOut() : super._();
}

*/
