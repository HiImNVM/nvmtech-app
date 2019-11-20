import 'package:flutter/widgets.dart';
import 'base.dart';

Type _typeOf<T>() => T;

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  const BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }) : super(key: key);

  final Widget child;
  final T bloc;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<_BlocProviderInherited<T>>();
    _BlocProviderInherited<T> provider =
        context.ancestorInheritedElementForWidgetOfExactType(type)?.widget;
    return provider?.bloc;
  }
}

class _BlocProviderState<T extends BlocBase> extends State<BlocProvider> {
  @override
  Widget build(BuildContext context) => _BlocProviderInherited<T>(
        bloc: widget.bloc,
        child: widget.child,
      );

  @override
  void dispose() {
    widget.bloc?.dispose();
    super.dispose();
  }
}

class MultiBlocProvider extends StatelessWidget
    implements SingleChildCloneableWidget {
  const MultiBlocProvider({
    Key key,
    @required this.blocProviders,
    @required this.child,
  })  : assert(blocProviders != null),
        super(key: key);

  final List<SingleChildCloneableWidget> blocProviders;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var node = child;
    for (final blocProvider in blocProviders.reversed) {
      node = blocProvider.cloneWithChild(node);
    }
    return node;
  }

  @override
  SingleChildCloneableWidget cloneWithChild(Widget child) => MultiBlocProvider(
        key: key,
        blocProviders: blocProviders,
        child: child,
      );
}

class _BlocProviderInherited<T> extends InheritedWidget {
  const _BlocProviderInherited({
    Key key,
    @required Widget child,
    @required this.bloc,
  }) : super(
          key: key,
          child: child,
        );

  final T bloc;

  @override
  bool updateShouldNotify(_BlocProviderInherited oldWidget) => false;
}
