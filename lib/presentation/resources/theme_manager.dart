import 'font_manager.dart';
import 'package:meshwary/presentation/resources/styles_manager.dart';

import 'values_manager.dart';
import 'package:flutter/material.dart';
import 'color_manager.dart';

class ThemeManager {
  static ThemeData getAppTheme() {
    return ThemeData(
      // main colors
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.lightPrimary,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey1,
      splashColor: ColorManager.lightPrimary,
      // card view theme
      cardTheme: CardTheme(
          color: ColorManager.white,
          shadowColor: ColorManager.grey,
          elevation: AppSize.s4),

      // app bar theme
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: ColorManager.primary,
          elevation: AppSize.s4,
          shadowColor: ColorManager.lightPrimary,
          titleTextStyle: StylesManager.getRegularStyle(
              fontSize: FontSizeManager.s16, color: ColorManager.white)),

      // button theme
      buttonTheme: ButtonThemeData(
          shape: const StadiumBorder(),
          disabledColor: ColorManager.grey1,
          buttonColor: ColorManager.primary,
          splashColor: ColorManager.lightPrimary),

      // elevated button them
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: StylesManager.getRegularStyle(
                  color: ColorManager.white, fontSize: FontSizeManager.s17),
              primary: ColorManager.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12)),
            minimumSize: const Size(double.infinity, 45),
          )),

      // textButtonTheme: TextButtonThemeData(
      //   style: ButtonStyle()
      // ),

      // text theme
      textTheme: TextTheme(
          displayLarge: StylesManager.getRegularStyle(
              color: ColorManager.white, fontSize: FontSizeManager.s22),
          headlineLarge: StylesManager.getSemiBoldStyle(
              color: ColorManager.darkGrey, fontSize: FontSizeManager.s16),
          // ----------- TextFormField -----------
          titleMedium: StylesManager.getRegularStyle(
              color: ColorManager.black, fontSize: FontSizeManager.s20),
          // -----------
          bodyLarge: StylesManager.getRegularStyle(color: ColorManager.grey1),
          bodySmall: StylesManager.getRegularStyle(color: ColorManager.grey)),
      // input decoration theme (text form field)
      inputDecorationTheme: InputDecorationTheme(

          // content padding
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
              vertical: AppPadding.p12, horizontal: AppPadding.p12),
          // hint style
          hintStyle: StylesManager.getRegularStyle(
              color: ColorManager.lightGrey, fontSize: FontSizeManager.s20),
          labelStyle: StylesManager.getRegularStyle(
              color: ColorManager.darkGrey, fontSize: FontSizeManager.s18),
          errorStyle: StylesManager.getRegularStyle(color: ColorManager.error),

          // enabled border style
          enabledBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.primary, width: AppSize.s1),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),

          // focused border style
          focusedBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),

          // error border style
          errorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.error, width: AppSize.s1_5),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s8))),
          // focused border style
          focusedErrorBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)))),
    );
  }
}
