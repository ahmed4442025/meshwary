import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshwary/app/functions/cubits/login/login_cubit.dart';
import 'package:meshwary/app/functions/cubits/login/login_states.dart';
import 'package:meshwary/presentation/resources/image_assets.dart';
import 'package:meshwary/presentation/resources/strings_manager.dart';
import 'package:meshwary/presentation/resources/widget_help.dart';

import '../resources/routes_maneger.dart';

class ForgetPassView extends StatelessWidget {
  // -------- vars -------
  late BuildContext myContext;
  late LoginCubit cubit;
  final _formKey = GlobalKey<FormState>();

  // -------- Text controllers --------
  TextEditingController userNameCtrl = TextEditingController();

  ForgetPassView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        myContext = context;
        cubit = LoginCubit.get(context);
        return myScaffold();
      },
    );
  }

  Scaffold myScaffold() => Scaffold(
        body: myBody(),
      );

  Widget myBody() => WidgetHelp.baseLoginBody(bodyWidgets(), formKey: _formKey);

  // -------- body widgets ----------
  List<Widget> bodyWidgets() {
    return [
      // phone Text field
      WidgetHelp.textFieldForm(
          label: StringsManager.phoneLabelLogin,
          hint: StringsManager.phoneHintLogin,
          controller: userNameCtrl),
      WidgetHelp.box20(),
      // buttons
      registerBT(),
      WidgetHelp.box20(),
      resendCode(),
      WidgetHelp.box15(),
      backToLogin(),
    ];
  }

  Widget registerBT() => WidgetHelp.button(
      onPressed: onForget, child: const Text(StringsManager.resetPassBT));

  Widget resendCode() => WidgetHelp.textLink(
      onPressed: () {}, txt: StringsManager.reSendCodeBT);

  Widget backToLogin() =>
      WidgetHelp.textLink(onPressed: gotoLoginPassView, txt: StringsManager.gotoLoginBT);

  // --------- void ----------
  void gotoForgetPassView() {
    Navigator.pushReplacementNamed(myContext, Routes.forgotPasswordRout);
  }

  void gotoLoginPassView() {
    Navigator.pushReplacementNamed(myContext, Routes.loginRout);
  }

  void onForget() {
    if (_formKey.currentState!.validate()) {
      print('forget pass');
    }
  }
}
