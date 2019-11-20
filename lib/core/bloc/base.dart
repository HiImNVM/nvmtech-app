import 'package:flutter/widgets.dart';

abstract class BlocBase {
  void dispose();
}

abstract class SingleChildCloneableWidget implements Widget {
  SingleChildCloneableWidget cloneWithChild(Widget child);
}
