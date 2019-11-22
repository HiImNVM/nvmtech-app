import 'package:flutter/cupertino.dart';
import 'package:nvmtech/src/styles/textStyle_style.dart';

class SuccessModal extends StatelessWidget {
  final String content;
  final String title;
  final String textButton;
  final Function onOk;

  const SuccessModal({
    this.content = '',
    this.title = 'Notice',
    this.textButton = 'OK',
    this.onOk,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          title,
          style: AppTextStyle.BLACK_W700_NORMAL_F18,
        ),
      ),
      content: Text(
        content,
        style: AppTextStyle.BLACK_W600_NORMAL_F12,
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          onPressed: this.onOk,
          child: Text(
            textButton,
            style: AppTextStyle.TOPAZ_W600_NORMAL_F12,
          ),
        )
      ],
    );
  }
}
