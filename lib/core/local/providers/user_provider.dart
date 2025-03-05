
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/features/auth/domain/models/user.dart';

@lazySingleton // Or @singleton if you want a single instance globally
class UserProvider extends ChangeNotifier {
  User? _user;
  String? _token;

  User? get user => _user;
  String? get token => _token;

  bool get isLoggedIn => _user != null;

  void login(String token) {
    _token = token;
    notifyListeners();
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void logout() {
    _token = null;
    _user = null;
    notifyListeners();
  }
}