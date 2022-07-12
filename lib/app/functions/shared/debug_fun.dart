import 'package:flutter/foundation.dart';

class DebugeC{
  static void printD(String txt){
    if (kDebugMode) {
      print(txt);
    }
  }
}