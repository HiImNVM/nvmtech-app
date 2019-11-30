import 'dart:async';
import 'package:flutter/services.dart';
import 'env.dart';

import 'package:flutter/material.dart';
import 'package:nvmtech/src/app.dart';

void main() {
  //lock the device orientation
  // => not allow it to change as the user rotates their phone,
  // Set always portrait up
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  
  //Build environment for other environment
  // Setup Env
  Env.appFlavor = Flavor.PROD;
  runZoned(() => runApp(MyApp()), onError: (error, stackTrace) {
    // TODO: Send error to server for tracking
  });
}
