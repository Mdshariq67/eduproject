

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationViewModel extends ChangeNotifier {
  SharedPreferences? _preferences;

  RegistrationViewModel() {
    _initPreferences();
  }

  Future<void> _initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<bool> registerUser(String fullname, String adddress, String email, String password) async {
    final userData = {
      'fullname': fullname,
      'address': adddress,
      'email': email,
      'password': password,
    };

    final success = await _saveUserData(userData);

    if (success) {
      notifyListeners();
    }

    return success;
  }

  Future<bool> _saveUserData(Map<String, String> userData) async {
    if (_preferences == null) {
      return false;
    }

    try {
      await _preferences!.setString('fullname', userData['fullname'] ?? '');
      await _preferences!.setString('address', userData['address'] ?? '');
      await _preferences!.setString('email', userData['email'] ?? '');
      await _preferences!.setString('password', userData['password'] ?? '');
      return true;
    } catch (e) {
      return false;
    }
  }
   Future<bool> updateAddress(String newAddress) async {
    if (_preferences == null) {
      return false;
    }

    try {
      await _preferences!.setString('address', newAddress);
      return true;
      
    } catch (e) {
      return false;
    }
  }
  bool isLoggedIn = false;

  Future<bool> loginUser(String email, String password) async {
    
    if (email == _preferences?.getString('email') && password == _preferences?.getString('password')) {
      isLoggedIn = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  
}
