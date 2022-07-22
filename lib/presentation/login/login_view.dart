import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshwary/app/functions/cubits/login/login_cubit.dart';
import 'package:meshwary/app/functions/cubits/login/login_states.dart';
import 'package:meshwary/app/functions/shared/cache_manager.dart';
import 'package:meshwary/presentation/resources/strings_manager.dart';
import 'package:meshwary/presentation/resources/views_sort_manager.dart';
import 'package:meshwary/presentation/resources/widget_help.dart';
import '../resources/routes_maneger.dart';

class LoginView extends StatelessWidget {
  // -------- vars -------
  late BuildContext myContext;
  late LoginCubit cubit;
  late LoginStates myState;
  final _formKey = GlobalKey<FormState>();

  // -------- Text controllers --------
  TextEditingController userNameCtrl =
      TextEditingController(text: CacheGet.loginUser);

  // password (deleted)
  // TextEditingController passwordCtrl =
  //     TextEditingController(text: CacheGet.loginPass);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (BuildContext context, state) {
        myState = state;
      },
      builder: (BuildContext context, state) {
        myContext = context;
        cubit = LoginCubit.get(context);
        myState = state;
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
      // password field (deleted)
      // WidgetHelp.textFieldForm(
      //     label: StringsManager.passwordLabelLogin, controller: passwordCtrl),
      // WidgetHelp.box20(),
      loginBT(),
      WidgetHelp.box20(),
      registerText()
    ];
  }

  // login button
  Widget loginBT() => WidgetHelp.button(
      onPressed: onLogin,
      disable: isActiveLoginBT(),
      child: const Text(StringsManager.loginBT));

  // link to register and forget password views
  Widget registerText() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WidgetHelp.textLink(
              onPressed: gotoForgetPassView,
              txt: StringsManager.goToForgetPassBT),
          WidgetHelp.textLink(
              onPressed: gotoRegisterView, txt: StringsManager.gotoSignUpBT),
        ],
      );

  // ---------- voids ---------
  // open register view
  void gotoRegisterView() => ViewsManager.openRegisterView(myContext);

  // open forget password view
  void gotoForgetPassView() => ViewsManager.openForgetPassView(myContext);

  // open confirm code
  void gotoConfirmView() => ViewsManager.openConfirmCodeView(myContext);

  Future<void> onLogin() async {
    _setLoginCache();
    if (_formKey.currentState!.validate() && userNameCtrl.text.length == 11) {
      await cubit.sendCode(userNameCtrl.text, false, gotoConfirmView);
    }
  }

  bool isActiveLoginBT() => (myState is LoginSendingCodeState);

  void _setLoginCache() {
    CacheGet.setLoginFields(userNameCtrl.text, 'passwordCtrl.text');
  }
}
