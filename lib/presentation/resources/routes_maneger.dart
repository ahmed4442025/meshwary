import 'package:meshwary/presentation/Forgot_password/forgot_password_view.dart';
import 'package:meshwary/presentation/login/login_view.dart';
import 'package:meshwary/presentation/main/main_view.dart';
import 'package:meshwary/presentation/onboarding/onboarding.dart';
import 'package:meshwary/presentation/register/confirm_code.dart';
import 'package:meshwary/presentation/register/register_view.dart';
import 'package:meshwary/presentation/resources/strings_manager.dart';
import 'package:meshwary/presentation/splash/splash_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRout = "/";
  static const String loginRout = "/login";
  static const String registerRout = "/register";
  static const String confirmPhoneRout = "/confirmPhone";
  static const String forgotPasswordRout = "/forgetPassword";
  static const String mainRout = "/main";
  static const String onBoardingRout = "/onBoarding";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRout:
        return MaterialPageRoute(builder: (_) => SplashView());
      case Routes.loginRout:
        return MaterialPageRoute(builder: (_) => LoginView());
      case Routes.registerRout:
        return MaterialPageRoute(builder: (_) => RegisterView());
      case Routes.confirmPhoneRout:
        return MaterialPageRoute(builder: (_) => ConfirmCodeView());
      case Routes.forgotPasswordRout:
        return MaterialPageRoute(builder: (_) => ForgetPassView());
      case Routes.mainRout:
        return MaterialPageRoute(builder: (_) => MainView());
      case Routes.onBoardingRout:
        return MaterialPageRoute(builder: (_) => OnBoardingView());
      default:
        return _unDefinedRout();
    }
  }

  static Route<dynamic> _unDefinedRout() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title:
                    const Text(StringsManager.noRouteFound),
              ),
              body: const Center(
                child: Text(StringsManager.noRouteFound),
              ),
            ));
  }
}
