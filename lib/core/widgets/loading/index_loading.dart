import 'package:flutter/cupertino.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(0, 0, 0, 0.5),
      child: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
