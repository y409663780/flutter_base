import 'base_tab_page_widget.dart';

///tab导航容器管理类
class TabNavigatorManager {
  ///首次加载，用于Tab基类
  bool isFirstLoad = false;

  Map<int,BaseTabPageState> _map;

  int preIndex = 0;

  bool isClick = false;

  Map<int,BaseTabPageState> get tabMap => _map;

  TabNavigatorManager._internal();

  static TabNavigatorManager _singleton = TabNavigatorManager._internal();

  factory TabNavigatorManager() => _singleton;


  void init(){
    if(_map == null){
      _map = Map();
    }
  }

  ///是否继承了Tab基类
  bool isUseBaseTab(int index){
    return _map.containsKey(index);
  }
}
