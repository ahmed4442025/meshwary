import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meshwary/presentation/resources/color_manager.dart';
import 'package:meshwary/presentation/resources/font_manager.dart';

class ToastManager {

  static void toastError(String msg){
    _showToast(msg, backgroundColor: ColorManager.toastError);
  }

  static void toastOk(String msg){
    _showToast(msg, backgroundColor: ColorManager.toastOk);
  }

  static void _showToast(String msg, {Color? backgroundColor}){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: ColorManager.white,
        fontSize: FontSizeManager.s14
    );
  }
}