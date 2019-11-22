import 'package:flutter/cupertino.dart';
import 'package:nvmtech/src/styles/textStyle_style.dart';

class PromptModal extends StatelessWidget {
  final String content;
  final String title;
  final String textRight;
  final String textLeft;
  final Function onTapRight;
  final Function onTapLeft;

  const PromptModal({
    this.content = '',
    this.title = 'Notice',
    this.textLeft = 'No',
    this.textRight = 'OK',
    this.onTapLeft,
    this.onTapRight,
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
          onPressed: this.onTapLeft,
          child: Text(
            textLeft,
            style: AppTextStyle.TOPAZ_W600_NORMAL_F12,
          ),
        ),
        CupertinoDialogAction(
          onPressed: this.onTapRight,
          child: Text(
            textRight,
            style: AppTextStyle.TOPAZ_W600_NORMAL_F12,
          ),
        ),
      ],
    );
  }
}
