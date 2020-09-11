import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusBarWrap extends StatelessWidget {
  final SystemUiOverlayStyle style;
  final Widget child;

  StatusBarWrap({Key key, this.style = SystemUiOverlayStyle.light, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(value: style, child: child);
  }
}
