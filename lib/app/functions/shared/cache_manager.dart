import 'package:meshwary/app/functions/shared/cache_helper.dart';
import 'package:meshwary/presentation/resources/cache_strings.dart';

class CacheGet {
  static void init() {
    _getLogin();
    _getRegister();
    // _getUserUID();
  }

  // ---------- login view ----------
  static late final String loginUser;
  static late final String loginPass;

  // get
  static void _getLogin() {
    loginUser = CacheHelper.getString(key: CacheStrings.loginUser) ?? '';
    loginPass = CacheHelper.getString(key: CacheStrings.loginPass) ?? '';
  }

  // set
  static void setLoginFields(String name, String pass) {
    CacheHelper.setString(key: CacheStrings.loginUser, value: name);
    CacheHelper.setString(key: CacheStrings.loginPass, value: pass);
  }

  // ---------- register view ----------
  static late final String registerName;
  static late final String registerPhone;
  static late final String registerEmail;
  static late final String registerPass;
  static late final String registerPic;

  // get
  static void _getRegister() {
    registerName = CacheHelper.getString(key: CacheStrings.registerName) ?? '';
    registerPhone =
        CacheHelper.getString(key: CacheStrings.registerPhone) ?? '';
    registerEmail =
        CacheHelper.getString(key: CacheStrings.registerEmail) ?? '';
    registerPass = CacheHelper.getString(key: CacheStrings.registerPass) ?? '';
    registerPic = CacheHelper.getString(key: CacheStrings.registerPic) ?? '';
  }

  // set
  static void setRegisterFields(String name, String phone, email, pass, pic) {
    CacheHelper.setString(key: CacheStrings.registerName, value: name);
    CacheHelper.setString(key: CacheStrings.registerPhone, value: phone);
    CacheHelper.setString(key: CacheStrings.registerEmail, value: email);
    CacheHelper.setString(key: CacheStrings.registerPass, value: pass);
    CacheHelper.setString(key: CacheStrings.registerPic, value: pic);
  }
}
