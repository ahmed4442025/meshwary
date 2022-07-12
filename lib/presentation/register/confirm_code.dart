import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshwary/app/functions/cubits/login/login_cubit.dart';
import 'package:meshwary/app/functions/cubits/login/login_states.dart';
import 'package:meshwary/presentation/resources/image_assets.dart';
import 'package:meshwary/presentation/resources/strings_manager.dart';
import 'package:meshwary/presentation/resources/widget_help.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../resources/routes_maneger.dart';

class ConfirmCodeView extends StatelessWidget {
  // -------- vars -------
  late BuildContext myContext;
  late LoginCubit cubit;
  final _formKey = GlobalKey<FormState>();

  // -------- Text controllers --------
  TextEditingController codeCtrl = TextEditingController();

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
      // code Field
      WidgetHelp.textFieldForm(
          label: StringsManager.codeLabelLogin,
          hint: StringsManager.codeHintLogin,
          controller: codeCtrl),
      WidgetHelp.box20(),
      // buttons
      registerBT(),
      WidgetHelp.box20(),
      backToLogin(),
      WidgetHelp.box20(),
    ];
  }

  Widget registerBT() =>
      WidgetHelp.button(onPressed: onConfirm, child: const Text(StringsManager.sendBT));

  Widget backToLogin() => WidgetHelp.textLink(
      onPressed: gotoLoginView, txt: StringsManager.gotoLoginBT2);

  // ------- void --------
  void gotoLoginView() {
    Navigator.pushReplacementNamed(myContext, Routes.loginRout);
  }

  Future<void> onConfirm() async {
    if (_formKey.currentState!.validate()) {
      print('object2');
      if (cubit.verificationId != null && codeCtrl.text.length == 6) {
        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: cubit.verificationId ?? '', smsCode: codeCtrl.text);
        // Sign the user in (or link) with the credential
        UserCredential s = await cubit.auth.signInWithCredential(credential);
        if (cubit.auth.currentUser != null) {
          addInfoToUser();
        }
      }
    }
  }

  void addInfoToUser() {
    if (cubit.auth.currentUser != null && cubit.userTemp != null) {
      cubit.auth.currentUser!.updateDisplayName(cubit.userTemp!.userName);
      cubit.auth.currentUser!.updateEmail(cubit.userTemp!.email ?? '');
      cubit.auth.currentUser!.updatePassword(cubit.userTemp!.password ?? '123');
    }
  }
}
