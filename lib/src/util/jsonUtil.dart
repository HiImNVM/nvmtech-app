import 'dart:convert';
import 'package:flutter/foundation.dart';

Future<dynamic> parseJSON(String text) => compute(jsonDecode, text);
