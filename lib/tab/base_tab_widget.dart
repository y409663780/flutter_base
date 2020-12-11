import 'package:flutter/material.dart';

import '../base_state_widget.dart';
import 'tab_navigator_manager.dart';

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
    if (!TabNavigatorManager().isClick && !TabNavigatorManager().isFirstLoad) {
      if (TabNavigatorManager().isUseBaseTab(TabNavigatorManager().preIndex)) {
        if(isAllTabRefresh()){
          TabNavigatorManager().tabMap.forEach((key, value) { value.didAppear();});
        }else{
          TabNavigatorManager()
              .tabMap[TabNavigatorManager().preIndex]
              .didAppear();
        }
      }
    }
  }

  /// 是否刷新所有Tab页面，响应所有Tab页面的didAppear回调方法，默认只刷新当前显示/回退后显示的页面
  /// 目前只处理didAppear的特殊情况，disappear不受影响
  bool isAllTabRefresh(){
    return false;
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
