import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshwary/app/functions/cubits/login/login_cubit.dart';
import 'package:meshwary/app/functions/cubits/login/login_states.dart';
import 'package:meshwary/data/models/user_model.dart';
import 'package:meshwary/presentation/resources/image_assets.dart';
import 'package:meshwary/presentation/resources/strings_manager.dart';
import 'package:meshwary/presentation/resources/widget_help.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../resources/routes_maneger.dart';

class RegisterView extends StatelessWidget {
  // -------- vars -------
  late BuildContext myContext;
  late LoginCubit cubit;
  final _formKey = GlobalKey<FormState>();

  // -------- Text controllers --------
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController password2Ctrl = TextEditingController();

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
      WidgetHelp.textFieldForm(
          label: "name", hint: 'john', controller: nameCtrl),
      WidgetHelp.box20(),
      WidgetHelp.textFieldForm(
          label: "phone number", hint: '010********', controller: phoneCtrl),
      WidgetHelp.box20(),
      WidgetHelp.textFieldForm(
          label: "email", hint: 'email@example.com', controller: emailCtrl),
      WidgetHelp.box20(),
      WidgetHelp.textFieldForm(label: "Password", controller: passwordCtrl),
      WidgetHelp.box20(),
      WidgetHelp.textFieldForm(
          label: "Confirm Password", controller: password2Ctrl),
      WidgetHelp.box20(),
      WidgetHelp.textFieldForm(label: "Profile Picture"),
      WidgetHelp.box20(),
      registerBT(),
      WidgetHelp.box20(),
      backToLogin(),
      WidgetHelp.box20(),
    ];
  }

  Widget registerBT() =>
      WidgetHelp.button(onPressed: onRegister, child: const Text(StringsManager.registerBT));

  Widget backToLogin() => WidgetHelp.textLink(
      onPressed: gotoLoginView, txt: StringsManager.gotoLoginBT2);

  // ------- void --------
  void gotoLoginView() {
    Navigator.pushReplacementNamed(myContext, Routes.loginRout);
  }

  void gotoConfirmView() {
    Navigator.pushReplacementNamed(myContext, Routes.confirmPhoneRout);
  }

  Future<void> onRegister() async {
    // all fields not empty
    if (_formKey.currentState!.validate()) {
      // 2 passwords is same
      if (passwordCtrl.text == password2Ctrl.text) {
        cubit.userTemp =
            UserTempModel(nameCtrl.text, passwordCtrl.text, emailCtrl.text);
        await sendCode();
      }
    }
  }

  // send Code to the phone and redirect to confirmCodeView
  Future<void> sendCode() async {
    if (phoneCtrl.text.length == 11) {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+20${phoneCtrl.text}',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        // if send code
        codeSent: (String verificationId, int? resendToken) {
          print("verificationId : $verificationId ,resendToken : $resendToken");
          cubit.verificationId = verificationId;
          gotoConfirmView();
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }
}
