import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tic_tac_toe_assignment/app/app.locator.dart';
import 'package:tic_tac_toe_assignment/ui/shared/styles.dart';

class CustomSnackbarService with ListenableServiceMixin {
  SnackbarService _snackbarService = locator<SnackbarService>();

  bool isActive = false;

  //custom snackbar
  showCustomSnackbar({required String message, required bool success}) async {
    if (isActive) return;

    isActive = true;
    notifyListeners();

    _snackbarService.registerSnackbarConfig(
      SnackbarConfig(
          backgroundColor: success ? kcGreenColor : kcRedColor,
          textColor: kcWhiteColor,
          mainButtonTextColor: kcBlackColor,
          snackPosition: SnackPosition.TOP,
          borderRadius: 5,
          titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );

    _snackbarService.showSnackbar(
      message: message,
      duration: Duration(seconds: success ? 3 : 5),
    );

    await Future.delayed(Duration(seconds: success ? 3 : 5));

    isActive = false;
    notifyListeners();
  }
}
