import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshwary/app/functions/cubits/fireAuth.dart';
import 'package:meshwary/app/functions/cubits/login/login_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meshwary/data/models/user_model.dart';
import 'package:meshwary/presentation/resources/strings_manager.dart';
import 'package:meshwary/presentation/resources/widget_help.dart';

import '../../shared/cache_manager.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void init() {
    bgImgPath = 'assets/images/bg/$_bgImgIndex.jpg';
  }

  // background color
  int _bgImgIndex = 1;
  late String bgImgPath;

  void changeBG() {
    _bgImgIndex++;
    if (_bgImgIndex >= 14) {
      _bgImgIndex = 1;
    }
    bgImgPath = "assets/images/bg/$_bgImgIndex.jpg";
    emit(LoginChangeBgState());
  }

  // phone auth
  String? _verificationId;
  String? phoneNumber;
  UserTempModel? userTemp;
  bool izNewAcc = false;

  // final FirebaseAuth auth = FirebaseAuth.instance;

  final FirebaseAuth auth = FireAuth.auth;

  // phone login

  // send Code to the phone and redirect to confirmCodeView
  Future sendCode(String phone, bool newAcc, void Function() onSend) async {
    phoneNumber = phone;
    emit(LoginSendingCodeState());
    await auth
        .verifyPhoneNumber(
      timeout: const Duration(seconds: 60),
      phoneNumber: '+20$phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) {},
      // verificationFailed
      verificationFailed: (FirebaseAuthException e) {
        emit(LoginSendErrorCodeState());
        WidgetHelp.toastError(StringsManager.codeSendError + e.toString());
      },
      // if send code
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        izNewAcc = newAcc;
        WidgetHelp.toastOk(StringsManager.codeSendOk);
        emit(LoginSendOkCodeState());
        onSend();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    )
        .catchError((e) {
          emit(LoginSendErrorCodeState());
      WidgetHelp.toastError(StringsManager.codeSendError + e.toString());
    });
  }

  Future confirmCode(String code, void Function() onSend) async {
    emit(LoginConfirmingCodeState());
    try{if (_verificationId != null) {
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId ?? '', smsCode: code);
      // Sign the user in (or link) with the credential
      await auth.signInWithCredential(credential);
      if (auth.currentUser != null) {
        createUserCloud(auth.currentUser?.uid ?? 'null');
        emit(LoginConfirmOkCodeState());
        onSend();
      }
    }} catch(e){
      WidgetHelp.toastError(StringsManager.error + e.toString());
      emit(LoginConfirmOkCodeState());
    }

  }

  // void _addInfoToUser() {
  //   if (auth.currentUser != null && userTemp != null && izNewAcc) {
  //     auth.currentUser!.updateDisplayName(userTemp?.userName);
  //   }
  // }

  // cloud
  void createUserCloud(String uid) {
    if (userTemp != null && izNewAcc) {
      UserFireModel user =
          UserFireModel(userTemp?.userName, userTemp?.phone, 0);
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(user.toJson())
          .then((value) {
        print('created usr ${userTemp?.userName} -> $uid');
      }).catchError((error) {
        print('take this error ${error.toString()}');
      });
    }
  }
}
