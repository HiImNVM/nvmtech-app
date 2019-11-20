import 'package:nvmtech/env.dart';

enum TypePrintf { ERROR, INFO }

void _printBase(dynamic value, TypePrintf typePrintf) {
  String prefix;
  switch (typePrintf) {
    case TypePrintf.ERROR:
      prefix = 'Error';
      break;

    default:
      prefix = 'Info';
  }

  if (Env.appFlavor == Flavor.PROD && typePrintf == TypePrintf.INFO) return;
  print('$prefix: $value');
}

void printError(dynamic value) => _printBase(value, TypePrintf.ERROR);
void printInfo(dynamic value) => _printBase(value, TypePrintf.INFO);
