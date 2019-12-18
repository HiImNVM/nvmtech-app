import 'dart:async';
import 'package:flutter/services.dart';

import 'core/store/shared_preferences.dart';
import 'env.dart';

import 'package:flutter/material.dart';
import 'package:nvmtech/src/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // Setup Env
  Env.appFlavor = Flavor.PROD;
  runZoned(() => runApp(MyApp()),
      onError: (error, stackTrace) => print(stackTrace));
}
