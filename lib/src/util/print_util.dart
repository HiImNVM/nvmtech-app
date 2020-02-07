import 'package:nvmtech/env.dart';

enum TypePrintf { ERROR, INFO, COUNT_BUILD }
Map<String, int> cachedCountRebuild = {};

String _getPrefix(TypePrintf typePrintf) {
  String prefix;
  switch (typePrintf) {
    case TypePrintf.ERROR:
      prefix = 'Error';
      break;
    case TypePrintf.COUNT_BUILD:
      prefix = 'ReBuild';
      break;
    default:
      prefix = 'Info';
  }

  return prefix;
}

void _printBase(dynamic value, TypePrintf typePrintf) {
  String prefix = _getPrefix(typePrintf);

  if (Env.appFlavor == Flavor.PROD && typePrintf == TypePrintf.INFO) return;

  if (typePrintf == TypePrintf.COUNT_BUILD) {
    int count = cachedCountRebuild[value];

    if (count == null) {
      count = 0;
    }

    cachedCountRebuild[value] = ++count;

    value = value + ' $count';
  }

  print('$prefix: $value');
}

void printError(dynamic value) => _printBase(value, TypePrintf.ERROR);
void printInfo(dynamic value) => _printBase(value, TypePrintf.INFO);
void printCountBuild(String value) => _printBase(value, TypePrintf.COUNT_BUILD);
