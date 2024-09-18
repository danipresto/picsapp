import 'package:flutter/material.dart';

class AdminModeProvider with ChangeNotifier {
  bool _isAdminMode = false;

  bool get isAdminMode => _isAdminMode;

  void enableAdminMode() {
    _isAdminMode = true;
    notifyListeners();
  }

  void disableAdminMode() {
    _isAdminMode = false;
    notifyListeners();
  }
}
