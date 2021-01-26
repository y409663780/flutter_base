import 'package:flutter/material.dart';

class DoubleBackTapExitApp extends StatefulWidget {
  final Widget child;
  final Duration duration;

  DoubleBackTapExitApp(
      {Key key, @required this.child, this.duration: const Duration(
          milliseconds: 2500)}) : super(key : key);

  @override
  State<StatefulWidget> createState() {
    return DoubleBackTapExitAppState();
  }
}

class DoubleBackTapExitAppState extends State<DoubleBackTapExitApp> {
  DateTime _lastTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _isExit,
      child: widget.child,
    );
  }

  Future<bool> _isExit() {
    /// 首次点击或者点击间隔大于指定间隔则记为初始点击
    if (_lastTime ==null || DateTime.now().difference(_lastTime) > widget.duration) {
      _lastTime = DateTime.now();
      return Future.value(false);
    }
    return Future.value(true);
  }
}
