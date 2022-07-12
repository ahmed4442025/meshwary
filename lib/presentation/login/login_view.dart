import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshwary/app/functions/cubits/login/login_cubit.dart';
import 'package:meshwary/app/functions/cubits/login/login_states.dart';
import 'package:meshwary/presentation/resources/image_assets.dart';
import 'package:meshwary/presentation/resources/strings_manager.dart';
import 'package:meshwary/presentation/resources/widget_help.dart';

import '../resources/routes_maneger.dart';

class LoginView extends StatelessWidget {
  // -------- vars -------
  late BuildContext myContext;
  late LoginCubit cubit;
  final _formKey = GlobalKey<FormState>();

  // -------- Text controllers --------
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

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
      // phone number field
      WidgetHelp.textFieldForm(
          label: StringsManager.phoneLabelLogin,
          hint: StringsManager.phoneHintLogin,
          controller: userNameCtrl),
      WidgetHelp.box20(),
      // password field
      WidgetHelp.textFieldForm(
          label: StringsManager.passwordLabelLogin, controller: passwordCtrl),
      WidgetHelp.box20(),
      loginBT(),
      WidgetHelp.box20(),
      registerText()
    ];
  }

  // login button
  Widget loginBT() =>
      WidgetHelp.button(onPressed: onLogin, child: const Text(StringsManager.loginBT));

  // link to register and forget password views
  Widget registerText() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WidgetHelp.textLink(
              onPressed: gotoForgetPassView, txt: StringsManager.goToForgetPassBT),
          WidgetHelp.textLink(
              onPressed: gotoRegisterView, txt: StringsManager.gotoSignUpBT),
        ],
      );

  // open register view
  void gotoRegisterView() {
    Navigator.pushReplacementNamed(myContext, Routes.registerRout);
  }

  // open forget password view
  void gotoForgetPassView() {
    Navigator.pushReplacementNamed(myContext, Routes.forgotPasswordRout);
  }

  void onLogin() {
    if (_formKey.currentState!.validate()) {
      cubit.auth.signInWithEmailAndPassword(
          email: userNameCtrl.text, password: '12345678');
      if (cubit.auth.currentUser != null) {
        print(cubit.auth.currentUser!.email);
      } else {
        print('no');
      }
    }
  }
}
