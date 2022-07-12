import 'package:flutter/material.dart';
import 'package:meshwary/app/services/background/test_serv.dart';
import 'package:meshwary/app/services/shared/get_location.dart';
import 'package:meshwary/presentation/resources/strings_manager.dart';
import '../resources/color_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body:  Center(
        child: InkWell(
            onTap: (){GetLocation.getLocation2();},
            child: const Text(StringsManager.onBoardMsg)),
      ),
    );
  }
}
