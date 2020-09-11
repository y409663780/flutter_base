import 'package:flutter/material.dart';

import '../base_state_widget.dart';
import 'tab_navigator_manager.dart';

import '../navigator_manager.dart';

///Tab page 基类
abstract class BaseTabPageWidget extends StatefulWidget {

  BaseTabPageWidget({Key key}) : super(key: key);

  @override
  BaseTabPageState<BaseTabPageWidget> createState() {
    return null;
  }
}

abstract class BaseTabPageState<T extends BaseTabPageWidget> extends State<T>
    with AutomaticKeepAliveClientMixin, BaseFunction {

  ///页面下标
  int getIndex();

  @override
  void initState() {
    TabNavigatorManager().init();
    TabNavigatorManager().tabMap[getIndex()] = this;

    TabNavigatorManager().isFirstLoad = true;
    initBaseCommon(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (TabNavigatorManager().isFirstLoad) {
        didAppear();
        TabNavigatorManager().isFirstLoad = false;
      }
    });
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;
}
