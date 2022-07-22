import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshwary/app/functions/cubits/login/login_cubit.dart';
import 'package:meshwary/app/functions/cubits/login/login_states.dart';
import 'package:meshwary/app/functions/shared/cache_manager.dart';
import 'package:meshwary/data/models/user_model.dart';
import 'package:meshwary/presentation/resources/strings_manager.dart';
import 'package:meshwary/presentation/resources/views_sort_manager.dart';
import 'package:meshwary/presentation/resources/widget_help.dart';

import '../resources/routes_maneger.dart';

class RegisterView extends StatelessWidget {
  // -------- vars -------
  late BuildContext myContext;
  late LoginCubit cubit;
  late LoginStates myState;
  final _formKey = GlobalKey<FormState>();

  // -------- Text controllers --------
  TextEditingController nameCtrl =
      TextEditingController(text: CacheGet.registerName);
  TextEditingController phoneCtrl =
      TextEditingController(text: CacheGet.registerPhone);

  // TextEditingController emailCtrl = TextEditingController(text: CacheGet.registerEmail);
  // TextEditingController passwordCtrl = TextEditingController(text: CacheGet.registerPass);
  // TextEditingController password2Ctrl = TextEditingController(text: CacheGet.registerPass);

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
      WidgetHelp.textFieldForm(
          label: "name", hint: 'john', controller: nameCtrl),
      WidgetHelp.box20(),
      WidgetHelp.textFieldForm(
          label: "phone number", hint: '010********', controller: phoneCtrl),
      WidgetHelp.box20(),

      // WidgetHelp.textFieldForm(
      //     label: "email", hint: 'email@example.com', controller: emailCtrl),
      // WidgetHelp.box20(),
      // WidgetHelp.textFieldForm(label: "Password", controller: passwordCtrl),
      // WidgetHelp.box20(),
      // WidgetHelp.textFieldForm(
      //     label: "Confirm Password", controller: password2Ctrl),
      // WidgetHelp.box20(),
      // WidgetHelp.textFieldForm(label: "Profile Picture"),
      // WidgetHelp.box20(),

      registerBT(),
      WidgetHelp.box20(),
      backToLogin(),
      WidgetHelp.box20(),
    ];
  }

  Widget registerBT() => WidgetHelp.button(
      onPressed: onRegister,
      disable: isActiveLoginBT(),
      child: const Text(StringsManager.registerBT));

  Widget backToLogin() => WidgetHelp.textLink(
      onPressed: gotoLoginView, txt: StringsManager.gotoLoginBT2);

  // ------- void --------
  void gotoLoginView() => ViewsManager.openLoginView(myContext);

  void gotoConfirmView() => ViewsManager.openConfirmCodeView(myContext);

  Future<void> onRegister() async {
    // cache last data usage
    _setRegisterCache();
    // all fields not empty
    if (_formKey.currentState!.validate() && phoneCtrl.text.length == 11) {
      cubit.userTemp = UserTempModel(nameCtrl.text, phoneCtrl.text);
      // send Code to the phone and redirect to confirmCodeView
      await cubit.sendCode(phoneCtrl.text, true, gotoConfirmView);
    }
  }

  bool isActiveLoginBT() => (myState is LoginSendingCodeState);

  void _setRegisterCache() {
    CacheGet.setRegisterFields(nameCtrl.text, phoneCtrl.text, 'emailCtrl.text',
        'passwordCtrl.text', 'NOT YET !');
  }
}
