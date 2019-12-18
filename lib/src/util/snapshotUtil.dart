import 'package:flutter/widgets.dart';
import 'package:nvmtech/src/util/printUtil.dart';

bool hasDataSnapshotUtil(AsyncSnapshot snapshot) {
  if (snapshot == null) return false;

  if (snapshot.hasError) {
    printError(snapshot.error);
    return false;
  }

  if (!snapshot.hasData) return false;
  return true;
}
