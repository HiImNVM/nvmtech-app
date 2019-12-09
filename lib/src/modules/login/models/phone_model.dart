import 'package:nvmtech/src/constants/countrycode_constant.dart';

class PhoneModel {
   String code;

  PhoneModel({this.code});

   static List<PhoneModel> listPhone = CONST_COUNTRY_CODES.map((item){
     return PhoneModel(code: item);
   }).toList();
  }


