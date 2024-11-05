import "dart:async";

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:menyusha/app/data/firebase/user/user_payload.dart";
import "package:menyusha/app/data/firebase/user/user_payload_repository.dart";
import "package:menyusha/app/data/firebase/user_manager.dart";

import "../../../../../data/firebase/auth/auth_state.dart";

class AuthenticationCubit extends Cubit<AuthState> {
  AuthenticationCubit(this._firebaseAuth)
      : super(AuthState.authInitial(true, "", "")) {
    init();
  }
  final getIt = GetIt.instance;

  late final UserPayloadRepository userRepository =
      getIt<UserPayloadRepository>();

  late final UserManager userManager = getIt<UserManager>();

  final FirebaseAuth _firebaseAuth;

  StreamSubscription<User?>? _authStateSubscription;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool isLoggedIn() => _firebaseAuth.currentUser != null;

  void init() {
    _authStateSubscription = _firebaseAuth.authStateChanges().listen(
      (final user) async {
        if (user == null) {
          print("User is currently signed out!");
          emit(AuthState.authInitial(true, "", ""));
        } else {
          // Optional: fetch or create user payload if needed
          final userPayload = await userRepository
              .getUserByUID(user!.uid);

          loginUser(user,userPayload!);
        }
      },
      onError: (final error) {
        print("Error listening to auth state changes: $error");
        emit(AuthState.authFailed(error.toString()));
      },
    );
  }

  void loginUser(final User user, final UserPayload userPayload) {
    print("User is signed in!");
    userManager.saveUser(userPayload);
    emit(AuthState.authSuccess(user, userPayload));
  }
  // login and registration

  Future<void> typeEmail(final String value) async {
    if (state is AuthInitial) {
      final authState = state as AuthInitial;
      emit(
        authState.copyWith(email: value),
      );
    } else {
      emit(AuthInitial(true, "", ""));
    }
  }

  Future<void> typePassword(final String value) async {
    if (state is AuthInitial) {
      final authState = state as AuthInitial;
      emit(
        authState.copyWith(password: value),
      );
    } else {
      emit(AuthInitial(true, "", ""));
    }
  }

  // login
  Future<void> restoreFailedLogin(
      final String email, final String password) async {
    if (state is AuthInitial) {
      final authState = state as AuthInitial;
      emit(
        authState.copyWith(email: email, password: password),
      );
    } else {
      emit(AuthInitial(true, email, password));
    }
  }

  Future<void> switchLogin() async {
    if (state is AuthInitial) {
      final authState = state as AuthInitial;
      emit(
        authState.copyWith(
          loginOpened: !authState.loginOpened,
        ),
      );
    } else {
      emit(AuthInitial(true, "", ""));
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
    await userManager.logout();
    emit(AuthState.authSignedOut()); // Emitting initial state after sign out
    switchLogin();
  }

  Future<void> signInWithGoogle() async {
    emit(AuthState.authLoading());
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        emit(AuthState.authFailed("Google sign-in canceled by user"));
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      // Optional: fetch or create user payload if needed
      final userPayload = await userRepository
          .findOrCreateUserPayloadByUID(userCredential.user!.uid);

      loginUser(userCredential.user!,userPayload!);
    } catch (e) {
      emit(AuthState.authFailed(_processSignInError(e)));
    }
  }

  Future<void> adminSignIn(
      final String email, final String password) async {
    emit(AuthState.authLoading());
    try {
      final userCredential = await _signIn("lenyk5665@gmail.com", "123123");
      final userPayload = await userRepository
          .getUserByUID(userCredential.user!.uid);
      loginUser(userCredential.user!,userPayload!);
    } catch (e) {
      emit(AuthState.authFailed(_processSignInError(e)));
    }
  }

  Future<void> signInWithEmailAndPassword(
      final String email, final String password) async {
    emit(AuthState.authLoading());
    try {
      final userCredential = await _signIn(email, password);
      final userPayload = await userRepository
          .getUserByUID(userCredential.user!.uid);
      loginUser(userCredential.user!,userPayload!);
    } catch (e) {
      emit(AuthState.authFailed(_processSignInError(e)));
    }
  }

  Future<void> signInOrRegisterWithEmailAndPassword(
      final String email, final String password) async {
    emit(AuthState.authLoading());
    try {
      final userCredential = await _attemptSignIn(email, password);

       final userPayload = await userRepository
           .findOrCreateUserPayloadByUID(userCredential.user!.uid);
      loginUser(userCredential.user!,userPayload!);
    } catch (e) {
      emit(AuthState.authFailed(_processSignInError(e)));
    }
  }

  Future<void> registerWithEmailAndPassword(
      final String email, final String password) async {
    emit(AuthState.authLoading());
    try {
      final userCredential = await _attemptRegister(email, password);
      final userPayload = await userRepository
          .createUser(userCredential.user!.uid);
      loginUser(userCredential.user!, userPayload!);
    } catch (e) {
      emit(AuthState.authFailed(_processSignInError(e)));
    }
  }

  String _processSignInError(final error) {
    if (error is FirebaseAuthException) {
      return _handleFirebaseAuthException(error);
    }
    return "Unexpected error: ${error.toString()}";
  }

  String _handleFirebaseAuthException(final FirebaseAuthException exception) {
    final code = exception.code;
    return _handleRegistrationError(code);
  }

  String _handleRegistrationError(final String? code) {
    switch (code) {
      case "email-already-in-use":
        return "The email address is already in use by another account.";
      case "invalid-email":
        return "The email address is not valid.";
      case "operation-not-allowed":
        return "Email/password accounts are not enabled.";
      case "weak-password":
        return "The password is too weak.";
      default:
        return _errorCodeToMessage(code);
    }
  }

  String _errorCodeToMessage(final String? code) {
    switch (code) {
      case "invalid-email":
        return "Invalid email";
      case "user-not-found":
        return "User not found. Please register.";
      case "wrong-password":
        return "Invalid password. Please try again.";
      case "weak-password":
        return "The password is too weak.";
      case null:
        return "Unknown error";
      default:
        return "Unexpected error: $code";
    }
  }

  Future<UserCredential> _attemptRegister(
      final String email, final String password) async {
    try {
      return await _register(email, password);
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  Future<UserCredential> _attemptSignIn(
      final String email, final String password) async {
    try {
      return await _signIn(email, password);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return _register(email, password);
      }
      throw e;
    }
  }

  Future<UserCredential> _signIn(
          final String email, final String password) async =>
      _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

  Future<UserCredential> _register(
          final String email, final String password) async =>
      _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    return super.close();
  }
}
