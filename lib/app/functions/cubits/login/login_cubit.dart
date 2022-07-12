import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshwary/app/functions/cubits/login/login_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meshwary/data/models/user_model.dart';
import '../../../../presentation/resources/routes_maneger.dart';

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
  String? verificationId;
  UserTempModel? userTemp;
  final FirebaseAuth auth = FirebaseAuth.instance;




}
