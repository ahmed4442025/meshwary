import 'dart:async';

import 'package:meshwary/app/functions/cubits/fireAuth.dart';
import 'package:meshwary/presentation/resources/app_constants.dart';
import 'package:meshwary/presentation/resources/color_manager.dart';
import 'package:meshwary/presentation/resources/image_assets.dart';
import 'package:meshwary/presentation/resources/routes_maneger.dart';
import 'package:flutter/material.dart';

import '../../app/functions/shared/cache_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer1;

  _startDelay() {
    _timer1 = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  void _goNext() {
    String nextPage =
        FireAuth.auth.currentUser == null ? Routes.loginRout : Routes.choseLineRout;
    Navigator.pushReplacementNamed(context, nextPage);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.primary,
        body: Center(
          child: Image.asset(ImageAssets.splashLogo),
        ));
  }

  @override
  void dispose() {
    _timer1?.cancel();
    super.dispose();
  }
}
