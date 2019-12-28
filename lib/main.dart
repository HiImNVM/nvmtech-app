import 'dart:async';
import 'package:flutter/services.dart';
import 'env.dart';

import 'package:flutter/material.dart';
import 'package:nvmtech/src/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //Build environment for other environment
  // Setup Env
  Env.appFlavor = Flavor.STAG;
  runZoned(() => runApp(MyApp()), onError: (error, stackTrace) {
    // TODO: Send error to server for tracking
  });
}
