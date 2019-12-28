import 'package:flutter/widgets.dart';

abstract class BlocBase {
  void dispose();
}

abstract class SingleChildCloneableWidget implements Widget {
  SingleChildCloneableWidget cloneWithChild(Widget child);
}

abstract class BlocEvent {
  dynamic eventName;
  dynamic value;
}
