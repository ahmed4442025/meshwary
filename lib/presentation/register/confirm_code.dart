import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshwary/app/functions/cubits/login/login_cubit.dart';
import 'package:meshwary/app/functions/cubits/login/login_states.dart';
import 'package:meshwary/presentation/resources/strings_manager.dart';
import 'package:meshwary/presentation/resources/views_sort_manager.dart';
import 'package:meshwary/presentation/resources/widget_help.dart';
import '../resources/routes_maneger.dart';

class ConfirmCodeView extends StatelessWidget {
  // -------- vars -------
  late BuildContext myContext;
  late LoginCubit cubit;
  late LoginStates myState;
  final _formKey = GlobalKey<FormState>();

  // -------- Text controllers --------
  TextEditingController codeCtrl = TextEditingController();

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
      // code Field
      WidgetHelp.textFieldForm(
          label: StringsManager.codeLabelLogin,
          hint: StringsManager.codeHintLogin,
          controller: codeCtrl),
      WidgetHelp.box20(),
      // buttons
      registerBT(),
      WidgetHelp.box20(),
      reSendCode(),
      backToLogin(),
      WidgetHelp.box20(),
    ];
  }

  Widget registerBT() => WidgetHelp.button(
      onPressed: onConfirm,
      disable: isActiveConfirmBT(),
      child: const Text(StringsManager.sendBT));

  Widget reSendCode() =>
      WidgetHelp.textLink(onPressed: _reSend, txt: StringsManager.reSendSMSBT);

  Widget backToLogin() => WidgetHelp.textLink(
      onPressed: gotoLoginView, txt: StringsManager.gotoLoginBT2);

  // ------- void --------
  void gotoLoginView() => ViewsManager.openLoginView(myContext);

  void gotoHomeView() => ViewsManager.tempHome(myContext);

  Future<void> onConfirm() async {
    if (_formKey.currentState!.validate() && codeCtrl.text.length == 6) {
      await cubit.confirmCode(codeCtrl.text, gotoHomeView);
    }
  }

  bool isActiveConfirmBT() =>
      (myState is LoginSendingCodeState || myState is LoginConfirmingCodeState);

  void _reSend() {
    if (cubit.phoneNumber != null) {
      cubit.sendCode(cubit.phoneNumber ?? '', cubit.izNewAcc, gotoHomeView);
    }
  }
}
