import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:meshwary/app/functions/shared/debug_fun.dart';
import 'package:meshwary/app/services/shared/get_location.dart';


class TestService {
  static void init() {
    DebugeC.printD('init Test Service');
    _getLocation();
    // _startTimer();
  }

  static Timer? _timer;
  static int count = 0;

  static void _startTimer() {
    _timer =
        Timer.periodic(const Duration(seconds: 3), (Timer t) => _runCode());
  }

  static void stopService() {
    DebugeC.printD('stopping timer');
    _timer?.cancel();
  }

  static void startService() {
    DebugeC.printD('starting timer');
    _startTimer();
  }

  static void _runCode() {
    DebugeC.printD("count : ${count++}");
  }

  static void _getLocation() async {
    // Position s = await GetLocation.determinePosition();
    // Position position = await Geolocator.getCurrentPosition();
    //
    // print(position);
    //
    LocationData? location = await GetLocation.getLocation2();
    print("location : ${location?.longitude} ;");

    // Position position = await GetLocation.determinePosition();
    // print(position.latitude);
  }
}
