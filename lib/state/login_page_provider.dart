import 'package:flutter/material.dart';

class LogInPageProvider extends ChangeNotifier {
  late String mainPageUserName;
  late String mainPagePassword;

  bool isLoadinglogin = false;

  void changeisLoadinglogin() {
    isLoadinglogin = !isLoadinglogin;
    notifyListeners();
  }

  bool isSnackbarPoped = true;

  void changeisSnackbarPoped() async {
    isSnackbarPoped = false;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2), () {
      isSnackbarPoped = true;
      notifyListeners();
    });
  }
}
