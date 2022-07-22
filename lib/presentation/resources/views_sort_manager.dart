import 'package:meshwary/app/functions/cubits/fireAuth.dart';
import 'package:meshwary/presentation/resources/routes_maneger.dart';
import 'package:flutter/material.dart';

class ViewsManager {
  // logic
  static homeAfterSplash(context) {
    FireAuth.auth.currentUser == null
        ? openLoginView(context)
        : tempHome(context);
  }

  static void tempHome(context) {
    openChoseLineView(context);
  }

  // const
  static void openLoginView(context) {
    _openViewNoBack(context, Routes.loginRout);
  }

  static void openRegisterView(context) {
    _openViewNoBack(context, Routes.registerRout);
  }

  static void openConfirmCodeView(context) {
    _openViewNoBack(context, Routes.confirmPhoneRout);
  }

  static void openChoseLineView(context) {
    _openViewNoBack(context, Routes.choseLineRout);
  }

  static void openForgetPassView(context) {
    _openViewNoBack(context, Routes.forgotPasswordRout);
  }

  static void openHomeView(context) {
    _openViewNoBack(context, Routes.mainRout);
  }

  static void openOnBoardingView(context) {
    _openViewNoBack(context, Routes.onBoardingRout);
  }

  // ==========
  static void _openViewNoBack(context, nextPage) {
    Navigator.pushReplacementNamed(context, nextPage);
  }
}
