import 'package:flutter/material.dart';
import 'data/datasource/auth_remote_datasource.dart';
import 'data/models/user.dart';
import '../../utils/preference_manager.dart';

class AuthProvider with ChangeNotifier {
  final AuthRemoteDatasourceImpl _authRemoteDatasource =
      AuthRemoteDatasourceImpl();

  AuthProvider() {
    _loadAuthData(); // Load saved user data on initialization
  }
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  // Load login state from SharedPreferences at startup
  Future<void> init() async {
    _isLoggedIn = await PreferenceManager.isLoggedIn();
    notifyListeners();
  }

  // Set login state and persist it
  Future<void> setLoggedIn() async {
    _isLoggedIn = true;
    await PreferenceManager.setLoggedIn(true);
    notifyListeners();
  }

  // Clear user data and login state (logout)
  Future<void> logout() async {
    await PreferenceManager.logout();
    _user = null;
    _isLoggedIn = false;
    notifyListeners();
  }

  //Auth Navigation router
  bool _onLoginPage = true;

  bool get onLoginPage => _onLoginPage;

  Future<void> switchAuthPage() async {
    _onLoginPage = !onLoginPage;
    notifyListeners();
  }

  String? _token;
  String? get token => _token;

  User? _user;
  User? get user => _user;

  // Load saved token and user data using PreferenceManager
  Future<void> _loadAuthData() async {
    _isLoggedIn = await PreferenceManager.isLoggedIn();
    _user = await PreferenceManager.getUser();
    notifyListeners();
  }

  // Save user data using PreferenceManager
  Future<void> _saveAuthData(User user) async {
    await PreferenceManager.saveUser(user);
    await PreferenceManager.setLoggedIn(true);
    _user = user;
    _isLoggedIn = true;
    notifyListeners();
  }

  // Login using AuthRemoteDatasourceImpl
  Future<bool> login(String username, String password) async {
    try {
      final user = await _authRemoteDatasource.login(username, password);
      print(user.toJson());
      await _saveAuthData(user);
      return true;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  // Sign up using AuthRemoteDatasourceImpl
  Future<bool> signUp(User user) async {
    try {
      final updatedUser = await _authRemoteDatasource.signUp(user);
      await _saveAuthData(updatedUser);
      return true;
    } catch (e) {
      print('Signup error: $e');
      return false;
    }
  }
}
