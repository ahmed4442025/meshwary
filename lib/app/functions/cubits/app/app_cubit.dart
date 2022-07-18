import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshwary/app/functions/cubits/fireAuth.dart';
import 'package:meshwary/data/models/user_model.dart';
import 'package:meshwary/presentation/resources/cache_strings.dart';
import '../../shared/cache_helper.dart';
import 'app_states.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  void init() {
    getUserInfoCloud();
  }

  // shared vars
  bool isDark = CacheHelper.getBool(key: CacheStrings.isDark) ?? false;
  List<int> lines = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

  // cache
  void changeIsDark() {
    isDark = !isDark;
    CacheHelper.setBool(key: 'isDark', value: isDark);
    emit(AppChangeDarkModState());
  }

  // cloud
  UserFireModel? userCloud;

  // get user info
  void getUserInfoCloud() async {
    if (FireAuth.uid != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FireAuth.uid)
          .get()
          .then((value) {
        userCloud = UserFireModel.fromJson(value.data() ?? {});
        print(userCloud?.toJson());
      }).catchError((e) {});
    }
  }

  // set user line
  void updateUserLineCloud(int line, void Function() onSend) async {
    if (FireAuth.uid != null && userCloud != null) {
      userCloud?.line = line;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FireAuth.uid)
          .set(userCloud!.toJson())
          .then((value) => onSend())
          .catchError((e) {});
    }
  }
}
