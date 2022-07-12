import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshwary/app/functions/cubits/app/app_cubit.dart';
import 'package:meshwary/app/functions/cubits/app/app_states.dart';



class TempHome extends StatelessWidget {
  TempHome({Key? key}) : super(key: key);
  late BuildContext context;
  late AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        context = context;
        cubit = AppCubit.get(context);
        return myScaffold();
      },
    );
  }

  Scaffold myScaffold() => Scaffold(
    appBar: AppBar(title: const Text('title'),),
    body: const Center(
      child: Text('New App !'),
    ),
  );
}
