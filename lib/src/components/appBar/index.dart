import 'package:flutter/material.dart';

Widget AppBarTransparent() => AppBar(
      leading: BackButton(color: Colors.grey),
      backgroundColor: Colors.transparent,
      bottomOpacity: 0.0,
      elevation: 0.0,
    );
