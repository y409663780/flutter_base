import 'package:flutter/material.dart';

import 'base_state_widget.dart';
import 'buildConfig.dart';

///组件栈管理器
class NavigatorManager {
  ///页面是否使用了基类
  bool isUseBase = false;

  bool isCallRemoved = false;

  ///储存组件名的容器
//  List<String> _activityStack = List<String>();

  ///储存状态组件的容器
  List<BaseWidgetState> _stateList = List<BaseWidgetState>();

  ///储存上下文的容器
  List<BuildContext> _contextList = List<BuildContext>();

  NavigatorManager._internal();

  //List<String> get stackList => _activityStack;

  List<BuildContext> get contextList => _contextList;

  static NavigatorManager _singleton = NavigatorManager._internal();

  factory NavigatorManager() => _singleton;

  ///获取组件名称
  String getWidgetName(BuildContext context) {
    if (context == null) {
      return "";
    }

    String className = context.toString();
    if (className == null) {
      return "";
    }

    if (BuildConfig.isDebug) {
      try {
        className = className.substring(0, className.indexOf("("));
      } catch (err) {
        className = "";
      }
    }
    return className;
  }

  ///把widget添加入栈
  void addWidget(BaseWidgetState state) {
    //_activityStack.add(getWidgetName(state.context));
    _stateList.add(state);
    _contextList.add(state.context);
  }

  ///把statelessWidget添加入栈
  void addStatelessWidget(BuildContext context) {
    String widgetName = getWidgetName(context);
    if (widgetName.isEmpty) return;
    //_activityStack.add(widgetName);
    _stateList.add(null);
    _contextList.add(context);
  }

  ///把widget移除出栈
  void removeWidget() {
    // _activityStack.removeLast();
    _stateList.removeLast();
    _contextList.removeLast();
  }

  ///判断statefulWidget页面是否处于栈顶
  bool isTopPage(BaseWidgetState state) {
    if (_stateList.isEmpty) {
      return false;
    }

    bool isCurrent = ModalRoute.of(state.context).isCurrent;
    return isCurrent;
  }

  ///获取栈内第一个组件
  BaseWidgetState getFirstPage() {
    if (_stateList == null || _stateList.length <= 0) {
      return null;
    }
    if (_stateList[_stateList.length - 1] == null) {
      print("这是一个无状态的组件");
    }
    return _stateList[_stateList.length - 1];
  }

  ///获取栈内第二个组件
  BaseWidgetState getSecondPage() {
    if (_stateList == null || _stateList.length <= 1) {
      return null;
    }
    if (_stateList[_stateList.length - 2] == null) {
      print("这是一个无状态的组件");
    }
    return _stateList[_stateList.length - 2];
  }

  ///栈顶是否是基类页面
  bool isBasePage({BuildContext context}) {
    if (_contextList.isEmpty) {
      return false;
    }
    bool current = false;
    if (context == null) {
      current = ModalRoute.of(_contextList.last).isCurrent;
    } else {
      current = ModalRoute.of(context).isCurrent;
    }
//    BuildContext context = _contextList.last;
//    bool current = ModalRoute.of(context).isCurrent;
//    wxLog(
//        "====isBasePage====isFirst====>${ModalRoute.of(_contextList.last).isFirst}===isActive===>${ModalRoute.of(_contextList.last).isActive}========current=====>$current");
    return current;
  }

  ///删除栈顶元素
  void removeLastPage() {
    if (_stateList.isEmpty) {
      return;
    }
    print(
        "isBasePage=================>${isBasePage(context: _contextList.last)}");
//    if (isBasePage(context: _contextList.last)) {
      //_activityStack.removeLast();
      _stateList.removeLast();
      _contextList.removeLast();
//    }
  }

  ///删除所有元素
  void removeAllPage() {
    _stateList.clear();
    //_activityStack.clear();
    _contextList.clear();
  }

  ///只保留栈内最后一个页面，用于navigator remove行为
  void remainLastPage() {
    ///主要是为了判断目标页面是否继承了基类
    WidgetsBinding.instance.addPostFrameCallback((r) {
      print("didRemove===isUseBase====>$isUseBase");
      if (isUseBase) {
        BaseWidgetState state = _stateList[_stateList.length - 1];
        BuildContext context = _contextList[_contextList.length - 1];
        removeAllPage();
        if (state == null) {
          addStatelessWidget(context);
        } else {
          addWidget(state);
        }
      } else {
        removeAllPage();
      }
      NavigatorManager().isCallRemoved = false;
    });
//    else {
//      removeAllPage();
//    }
  }
}
