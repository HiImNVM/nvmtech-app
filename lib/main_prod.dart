import 'dart:async';
import 'env.dart';

import 'package:flutter/material.dart';
import 'package:nvmtech/src/app.dart';

void main() {
  // Setup Env
  Env.appFlavor = Flavor.STAG;

  runZoned(() => runApp(MyApp()),
      onError: (error, stackTrace) => print(stackTrace));
}
