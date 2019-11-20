import 'dart:async';
import 'env.dart';

import 'package:flutter/material.dart';
import 'package:nvmtech/src/app.dart';

void main() {
  // Setup Env
  Env.appFlavor = Flavor.PROD;
  runApp(MyApp());
  // runZoned(() => runApp(MyApp()), onError: (error, stackTrace) {
  //   // TODO: Send error to server for tracking
  // });
}
