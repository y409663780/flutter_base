import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'navigator_manager.dart';

///无状态组件基类
abstract class BaseStatelessWidget extends StatelessWidget {
  ///判断是否是Push过来的，1.17之前的版本pop时会调用build
  bool _isPush = false;

  BaseStatelessWidget() {
    _isPush = true;
  }

  Widget buildWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    bool isCurrent = ModalRoute.of(context).isCurrent;
    if (isCurrent && _isPush) {
      ///把当前组件添加进组件栈
      NavigatorManager().addStatelessWidget(context);
      _isPush = false;
    }

    return buildWidget(context);
  }
}
