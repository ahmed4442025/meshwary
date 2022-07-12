import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meshwary/app/functions/shared/cache_helper.dart';
import 'package:meshwary/app/services/background/test_serv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'app/app.dart';
import 'app/functions/cubits/block_observer.dart';


void main() async {
  BlocOverrides.runZoned(
        () async {
          WidgetsFlutterBinding.ensureInitialized();
          // TestService.init();
          await CacheHelper.init();
          await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          );
          runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}