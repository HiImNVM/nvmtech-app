import 'dart:async';

import 'package:flutter/material.dart';

class CountDownTime extends StatefulWidget {
  CountDownTime({
    @required this.time,
    this.style,
    this.endTime = 0,
    this.onEnd,
    this.onChange,
  });

  int time;
  final TextStyle style;
  final int endTime;
  final VoidCallback onEnd;
  final Function(int time) onChange;

  @override
  _CountDownTimeState createState() => _CountDownTimeState();
}

class _CountDownTimeState extends State<CountDownTime> {
  Timer _timer;
  final Duration _oneSec = const Duration(seconds: 1);

  @override
  void initState() {
    super.initState();

    _start();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${this._formatCountDownTime(this.widget.time)}',
      style: this.widget?.style,
    );
  }

  @override
  void didUpdateWidget(CountDownTime oldWidget) {
    if (oldWidget.time != this.widget.time) {
      if (this._timer == null || !this._timer.isActive) {
        oldWidget.time = this.widget.time;
        _start();
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  void _start() {
    this._timer = new Timer.periodic(
      this._oneSec,
      (Timer timer) {
        if (this.widget.endTime == this.widget.time) {
          this._timer?.cancel();
          if (this.widget.onEnd != null) this.widget.onEnd();
          return;
        }

        this.setState(
          () {
            --this.widget.time;
            if (this.widget.onChange != null) {
              this.widget.onChange(this.widget.time);
            }
          },
        );
      },
    );
  }

  String _formatCountDownTime(int time) {
    if (time == null || time == 0) {
      return '00:00';
    }

    return (time / 60).floor().toString().padLeft(2, '0') +
        ':' +
        (time % 60).toString().padLeft(2, '0');
  }

  @override
  void dispose() {
    this._timer?.cancel();
    this._timer = null;

    super.dispose();
  }
}
