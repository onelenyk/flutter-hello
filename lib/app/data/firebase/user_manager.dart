import 'dart:html';
import 'dart:convert';

import "package:menyusha/app/data/firebase/user/user_payload.dart";

class UserManager {
  static const String _userKey = 'user';
  bool _isUserLoggedIn = false;

  UserManager() {
    // Initialize the logged-in status from localStorage
    _isUserLoggedIn = window.localStorage.containsKey(_userKey);
  }

  // Save user data to local storage
  Future<void> saveUser(UserPayload user) async {
    final StorageService storage = StorageService();
    String userJson = jsonEncode(user.toJson());
    await storage.setItem(_userKey, userJson);
    _isUserLoggedIn = true;
  }

  // Get user data from local storage
  Future<UserPayload?> getUser() async {
    final StorageService storage = StorageService();
    String? userJson = await storage.getItem(_userKey);
    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return UserPayload.fromJson(userMap);
    }
    return null;
  }

  // Check if user is logged in asynchronously
  Future<bool> isUserLoggedIn() async {
    final StorageService storage = StorageService();
    return await storage.containsKey(_userKey);
  }

  // Check if user is logged in synchronously
  bool isUserLoggedInSync() {
    return _isUserLoggedIn;
  }

  // Log out user by removing user data from local storage
  Future<void> logout() async {
    final StorageService storage = StorageService();
    await storage.removeItem(_userKey);
    _isUserLoggedIn = false;
  }
}

class StorageService {
  // Save item to localStorage
  Future<void> setItem(final String key, final String value) async {
    window.localStorage[key] = value;
  }

  // Get item from localStorage
  Future<String?> getItem(final String key) async => window.localStorage[key];

  // Remove item from localStorage
  Future<void> removeItem(final String key) async {
    window.localStorage.remove(key);
  }

  // Check if item exists in localStorage
  Future<bool> containsKey(final String key) async =>
      window.localStorage.containsKey(key);
}

void main() async {
  final userManager = UserManager();

  // Example Usage
  final user = UserPayload(id: "test", uid: "TEST UID");

  // Save user
  await userManager.saveUser(user);

  // Check if user is logged in
  var isLoggedIn = await userManager.isUserLoggedIn();
  print('Is user logged in? $isLoggedIn');

  // Get user info
  final UserPayload? fetchedUser = await userManager.getUser();
  if (fetchedUser != null) {
    print('User Name: ${fetchedUser.uid}');
  }

  // Log out user
  await userManager.logout();
  isLoggedIn = await userManager.isUserLoggedIn();
  print('Is user logged in after logout? $isLoggedIn');
}
