import 'package:flutter/material.dart';

import 'tab_navigator_manager.dart';

import '../base_state_widget.dart';
import '../navigator_manager.dart';

class BaseTabWidget extends BaseStatefulWidget {

  BaseTabWidget({Key key}) : super(key: key);

  @override
  BaseWidgetState<BaseStatefulWidget> createState() {
    return null;
  }
}

abstract class BaseTabState<T extends BaseTabWidget>
    extends BaseWidgetState<T> {
  @override
  void didAppear() {
    super.didAppear();
    print(
        "isFirstLoad====>${TabNavigatorManager().isFirstLoad}=====isClick====>${TabNavigatorManager().isClick}");
    if (!TabNavigatorManager().isClick && !TabNavigatorManager().isFirstLoad) {
      if (TabNavigatorManager().isUseBaseTab(TabNavigatorManager().preIndex)) {
        TabNavigatorManager()
            .tabMap[TabNavigatorManager().preIndex]
            .didAppear();
      }
    }
  }

  @override
  void disappear() {
    super.disappear();
    TabNavigatorManager().isClick = false;
    if (TabNavigatorManager().isUseBaseTab(TabNavigatorManager().preIndex)) {
      TabNavigatorManager().tabMap[TabNavigatorManager().preIndex].disappear();
    }
  }

  @override
  void onForeground() {
    super.onForeground();
    if (TabNavigatorManager().isUseBaseTab(TabNavigatorManager().preIndex)) {
      TabNavigatorManager()
          .tabMap[TabNavigatorManager().preIndex]
          .onForeground();
    }
  }

  @override
  void onBackground() {
    super.onBackground();
    if (TabNavigatorManager().isUseBaseTab(TabNavigatorManager().preIndex)) {
      TabNavigatorManager()
          .tabMap[TabNavigatorManager().preIndex]
          .onBackground();
    }
  }
}
