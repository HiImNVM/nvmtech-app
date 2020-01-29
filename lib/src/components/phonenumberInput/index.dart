import 'package:flutter/material.dart';

class PhoneNumberInput extends StatefulWidget {
  PhoneNumberInput({
    this.contryCodes = const [],
    this.width = 150,
    this.height = 150,
    this.borderRadius = 5,
    this.backgroundContryCode = const Color(0xffd8d8d8),
    this.backgroundMobileNumber = const Color(0xfff1f2f6),
    this.onChanged,
  });

  final List<String> contryCodes;
  final double width;
  final double height;
  final double borderRadius;
  final Color backgroundContryCode;
  final Color backgroundMobileNumber;
  final Function(String text) onChanged;

  @override
  _PhoneNumberInputState createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  TextEditingController _phoneNumberCtrl;
  String _selectedContryCode;

  @override
  void initState() {
    super.initState();

    this._phoneNumberCtrl = TextEditingController();
    this._phoneNumberCtrl.addListener(() => this
        .widget
        .onChanged(this._selectedContryCode + this._phoneNumberCtrl.text));
    this._selectedContryCode = this.widget.contryCodes.first;
  }

  List<DropdownMenuItem<String>> _renderItems() {
    return this
        .widget
        .contryCodes
        .map<DropdownMenuItem<String>>((String contryCode) {
      return DropdownMenuItem(
        value: contryCode,
        child: SizedBox(
          width: 40,
          child: Text(
            contryCode,
            textAlign: TextAlign.right,
          ),
        ),
      );
    }).toList();
  }

  Widget _renderContryCode() {
    return Container(
      decoration: BoxDecoration(
        color: this.widget.backgroundContryCode,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(this.widget.borderRadius),
          bottomLeft: Radius.circular(this.widget.borderRadius),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          onChanged: this._handleOnChangedContryCode,
          value: this._selectedContryCode,
          items: this._renderItems(),
        ),
      ),
    );
  }

  Widget _renderMobileNumber() {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
            color: this.widget.backgroundMobileNumber,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(this.widget.borderRadius),
              topRight: Radius.circular(this.widget.borderRadius),
            )),
        child: TextField(
          controller: this._phoneNumberCtrl,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Mobile Number',
          ),
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.widget.width,
      height: this.widget.height,
      child: Row(
        children: <Widget>[
          this._renderContryCode(),
          this._renderMobileNumber(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    this._phoneNumberCtrl?.dispose();

    super.dispose();
  }

  void _handleOnChangedContryCode(String code) {
    this.setState(() {
      this._selectedContryCode = code;
      this.widget.onChanged(code + this._phoneNumberCtrl.text);
    });
  }
}
