import 'package:flutter/material.dart';

import 'navigator_manager.dart';

///statefulWidget组件基类
abstract class BaseStatefulWidget extends StatefulWidget {
  BaseStatefulWidget({Key key}) : super(key: key);

  @override
  BaseWidgetState<BaseStatefulWidget> createState() {
    return null;
  }
}

///statefulWidget组件状态基类
abstract class BaseWidgetState<T extends BaseStatefulWidget> extends State<T>
    with WidgetsBindingObserver, BaseFunction {
  @override
  void initState() {
    initBaseCommon(this);
    NavigatorManager().addWidget(this);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  @Deprecated(
      "After the version of 1.17,deactivate() is only called by the new page when the new page back to the old .\nFor compatibility with previous versions，It's replaced by didAppear() and disappear() for more explicit scene.")
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    pageLog("dispose");
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (NavigatorManager().isTopPage(this)) {
        onForeground();
        pageLog("从后台回来");
      }
    } else if (state == AppLifecycleState.paused) {
      if (NavigatorManager().isTopPage(this)) {
        onBackground();
        pageLog("从前台到后台");
      }
    }
    super.didChangeAppLifecycleState(state);
  }
}

///基类功能类
abstract class BaseFunction {
  BuildContext _buildContext;

  ///页面回到栈顶,可重写
  void didAppear() {
    pageLog("回来了");
  }

  ///页面暂停，被覆盖,可重写
  void disappear() {
    pageLog("隐藏了");
  }

  ///app切回到后台,可重写
  void onBackground() {}

  ///app切回到前台,可重写
  void onForeground() {}

  ///打印信息
  void pageLog(String content) {
    print(
        "baseWidgetPage===========>${NavigatorManager().getWidgetName(_buildContext)} -------: $content");
  }

  ///返回屏幕宽度
  double getScreenWidth() {
    return MediaQuery.of(_buildContext).size.width;
  }

  ///返回屏幕高度
  double getScreenHeight() {
    return MediaQuery.of(_buildContext).size.height;
  }
//  }

  void initBaseCommon(State state) {
    _buildContext = state.context;
  }
}

///页面切换监听类
class BaseNavigationObserver extends NavigatorObserver {
  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    ///首先，先判断上个页面是不是基类页面
    if (NavigatorManager().isUseBase) {
      /// 判断上个页面是否是有状态组件页面
      if (NavigatorManager().getFirstPage() != null) {
        ///如果是，则上个页面调用disappear方法，表示页面已经隐藏
        NavigatorManager().getFirstPage().disappear();
      }

      ///路由栈删除上个页面的路由节点
      NavigatorManager().removeLastPage();
    }

    ///接着在渲染完成回调里继续处理相关逻辑
    WidgetsBinding.instance.addPostFrameCallback((r) {
      ///判断当前页面是不是基类页面
      if (NavigatorManager().isBasePage()) {
        NavigatorManager().isUseBase = true;

        ///如果是，则继续判断当前页面是不是有状态页面
        if (NavigatorManager().getFirstPage() != null) {
          ///如果是有状态页面，则当前页面调用didAppear方法，表示页面已渲染完成
          NavigatorManager().getFirstPage().didAppear();
        }
      } else {
        ///如果不是基类页面，基类标志位置为false
        NavigatorManager().isUseBase = false;
      }
    });
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    if (previousRoute == null) {
      if (!NavigatorManager().isCallRemoved) {
        NavigatorManager().remainLastPage();
        NavigatorManager().isCallRemoved = true;
      }
    } else {
      ///TODO 未完成，只适用于全接入的情况
      if(NavigatorManager().isUseBase){
        if(NavigatorManager().getSecondPage() != null){
          BaseWidgetState state = NavigatorManager().getSecondPage();
          if(ModalRoute.of(state.context).isActive){
            NavigatorManager().removeLastPage();
          }
        }

        if(NavigatorManager().getFirstPage() != null){
          BaseWidgetState state = NavigatorManager().getFirstPage();
          if(ModalRoute.of(state.context).isActive){
            NavigatorManager().isUseBase = true;
          }else{
            NavigatorManager().isUseBase = false;
          }
        }
      }else{
        if(NavigatorManager().getFirstPage() != null){
          BaseWidgetState state = NavigatorManager().getFirstPage();
          if(ModalRoute.of(state.context).isActive){
            NavigatorManager().removeLastPage();
            NavigatorManager().isUseBase = true;
          }else{
            NavigatorManager().isUseBase = false;
          }
        }
      }
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    ///首先，先判断上个页面是不是基类页面
    if (NavigatorManager().isUseBase) {
      /// 判断上个页面是否是有状态组件页面
      if (NavigatorManager().getFirstPage() != null) {
        ///如果是，则上个页面调用disappear方法，表示页面已经隐藏
        NavigatorManager().getFirstPage().disappear();
      }

      ///路由栈删除上个页面的路由节点
      NavigatorManager().removeLastPage();
    }

    ///接着在渲染完成回调里继续处理相关逻辑
    WidgetsBinding.instance.addPostFrameCallback((r) {
      ///判断当前页面是不是基类页面
      if (NavigatorManager().isBasePage()) {
        ///基类标志位置为true
        NavigatorManager().isUseBase = true;

        ///如果是，则继续判断当前页面是不是有状态页面
        if (NavigatorManager().getFirstPage() != null) {
          ///如果是有状态页面，则当前页面调用didAppear方法，表示页面已渲染完成
          NavigatorManager().getFirstPage().didAppear();
        }
      } else {
        ///如果不是基类页面，基类标志位置为false
        NavigatorManager().isUseBase = false;
      }
    });
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    ///有状态组件 =>无状态组件
    ///有状态组件 =>未继承组件
    ///有状态组件 =>有状态组件

    ///无状态组件 =>有状态组件
    ///无状态组件 =>未继承组件
    ///无状态组件 =>无状态组件

    ///未继承组件 =>有状态组件
    ///未继承组件 =>未继承组件
    ///未继承组件 =>无状态组件

    ///首先，先判断上个页面是不是基类页面
    if (NavigatorManager().isUseBase) {
      if (NavigatorManager().getFirstPage() != null) {
        ///如果上个页面是有状态的基类页面，则调用disappear方法，表示页面已隐藏
        NavigatorManager().getFirstPage().disappear();
      }

      ///如果是，则在渲染完成回调里继续处理相关逻辑
      WidgetsBinding.instance.addPostFrameCallback((r) {
        ///判断当前页面是否是继承于基类的页面
        if (NavigatorManager().isBasePage()) {
          NavigatorManager().isUseBase = true;

          ///如果是基类页面，则判断页面是否是继承有状态组件基类的组件
          if (NavigatorManager().getFirstPage() != null) {
            ///有状态组件页面则调用didAppear生命周期方法，表示页面渲染完成
            NavigatorManager().getFirstPage().didAppear();
          }
        } else {
          ///当前页面未继承基类页面
          NavigatorManager().isUseBase = false;
        }
      });
    } else {
      ///上个页面是未继承基类的页面
      WidgetsBinding.instance.addPostFrameCallback((r) {
        ///判断当前页面是否是基类页面
        if (NavigatorManager().isBasePage()) {
          NavigatorManager().isUseBase = true;

          ///判断当前页面是否是有状态的基类页面
          if (NavigatorManager().getFirstPage() != null) {
            ///如果是，则当前页面调用didAppear，表示页面渲染完成，可见
            NavigatorManager().getFirstPage().didAppear();
          }
        } else {
          ///如果不是基类页面，基类标志位置为false
          NavigatorManager().isUseBase = false;
        }
      });
    }
  }
}
