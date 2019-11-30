import 'package:flutter/material.dart';
import 'package:nvmtech/src/util/printUtil.dart';

bool snapshotUtil(dynamic snapshot){
  if (snapshot.hasError) {
    printError(snapshot.error);
    return true;
  }

  if (!snapshot.hasData) return false;
}