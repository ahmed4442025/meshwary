import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshwary/app/functions/cubits/app/app_cubit.dart';
import 'package:meshwary/app/functions/cubits/app/app_states.dart';
import 'package:meshwary/presentation/resources/routes_maneger.dart';
import 'package:meshwary/presentation/resources/views_sort_manager.dart';
import 'package:meshwary/presentation/resources/widget_help.dart';

class ChoseLineView extends StatelessWidget {
  ChoseLineView({Key? key}) : super(key: key);
  late BuildContext _context;
  late AppCubit _cubit;
  final _formKey = GlobalKey<FormState>();

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
        body: WidgetHelp.baseLoginBody(bodyWidgets()),
        // body: _choseAge(),
      );

  List<Widget> bodyWidgets() {
    return [_choseULine(), WidgetHelp.box20(), _choseAge()];
  }

  Widget _choseULine() => const Text('chose your line',
      style: TextStyle(fontSize: 30, color: Colors.black54));

  Widget _choseAge() => Center(
        child: SizedBox(
            height: 240,
            child: SingleChildScrollView(
              child: Column(
                children: _allLines(),
              ),
            )),
      );

  List<Widget> _allLines() {
    List<Widget> temp = [];
    for (var value in _cubit.lines) {
      temp.add(_oneLine(value));
    }
    return temp;
  }

  Widget _oneLine(int line) => InkWell(
      onTap: () {
        _cubit.updateUserLineCloud(line, _gotoMainView);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          line.toString(),
          style: const TextStyle(fontSize: 30, color: Colors.blue),
        ),
      ));

  void _gotoMainView() => ViewsManager.openHomeView(_context);
}
