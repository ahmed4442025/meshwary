import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshwary/app/functions/cubits/app/app_cubit.dart';
import 'package:meshwary/app/functions/cubits/app/app_states.dart';
import 'package:meshwary/presentation/resources/views_sort_manager.dart';
import 'package:meshwary/presentation/resources/widget_help.dart';
import 'package:meshwary/app/functions/cubits/fireAuth.dart';

class MainView extends StatelessWidget {
  MainView({Key? key}) : super(key: key);
  late BuildContext _context;
  late AppCubit _cubit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        _context = context;
        _cubit = AppCubit.get(context);
        return myScaffold();
      },
    );
  }

  Scaffold myScaffold() => Scaffold(
        appBar: AppBar(
          title: const Text('title'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('welcome ${_cubit.userCloud?.name}'),
              Text('phone : ${_cubit.userCloud?.phone}'),
              Text('uid : ${FireAuth.uid}'),
              Text('line : ${_cubit.userCloud?.line}'),
              WidgetHelp.textLink(onPressed: _logOut, txt: 'log out')
            ],
          ),
        ),
      );

  // --------- void ----------
  _logOut() {
    if (FireAuth.auth.currentUser != null) {
      FireAuth.auth.signOut();
    }
    _goToLogin();
  }

  _goToLogin() => ViewsManager.openLoginView(_context);
}
