import 'dart:async';
import 'package:flutter/services.dart';

import 'env.dart';

import 'package:flutter/material.dart';
import 'package:nvmtech/src/app.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // Setup Env
  Env.appFlavor = Flavor.STAG;

  runZoned(() => runApp(MyApp()),
      onError: (error, stackTrace) => print(stackTrace));
}
