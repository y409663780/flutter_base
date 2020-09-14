# flutter_base
Base for developing Flutter apps.It provides the function of life cycles.In addition to the original life cycle of the system, it also provides additional life cycle methods of disappear, didAppear, onForeground, and onBackground

## Usage

dependencies: flutter_lifecycle_base: ^1.0.2

Since the base class is implemented based on NavigatorObserver, you must register `BaseNavigatorObserver` under materialApp

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      navigatorObservers: [BaseNavigationObserver()],
    );
  }
}
```

It has two parts:  normal and Tab.Next，provides their usage examples.

### Normal

```dart
class BaseTestPage extends BaseStatefulWidget {
  @override
  _BaseTestPageState createState() {
    return _BaseTestPageState();
  }
}

class _BaseTestPageState extends BaseWidgetState<BaseTestPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text("BaseTestPage"),
      )
    );
  }
  
  @override
  void didAppear() {
    super.didAppear();
  }

  @override
  void disappear() {
    super.disappear();
  }

  @override
  void onForeground() {
    super.onForeground();
  }

  @override
  void onBackground() {
    super.onBackground();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
```



### Tab

The code of Tab container:

```dart
class MainBottomTabView extends BaseTabWidget {

  @override
  _MainBottomTabViewState createState() => _MainBottomTabViewState();
}

class _MainBottomTabViewState extends BaseTabState<MainBottomTabView> {
  int _currentIndex;
  List<Widget> _pages;
  PageController _controller;

  List<Widget> pages = [
    FirstPage(),
    SecondPage(),
    ThirdPage()
  ];

  List<BottomNavigationBarItem> tabList = [
    BottomNavigationBarItem(
        icon: Image.asset('assets/images/icon_main_tab_first_default.png'),
        title: Text(
          'First',
         // style: labelStyle,
        ),
        activeIcon:
        Image.asset('assets/images/icon_main_tab_first_selected.png')),
    BottomNavigationBarItem(
        icon: Image.asset('assets/images/icon_main_tab_second_default.png'),
        title: Text(
          'Second',
          //style: labelStyle,
        ),
        activeIcon:
        Image.asset('assets/images/icon_main_tab_second_selected.png')),
    BottomNavigationBarItem(
        icon: Image.asset('assets/images/icon_main_tab_third_default.png'),
        title: Text(
          'Third',
         // style: labelStyle,
        ),
        activeIcon:
        Image.asset('assets/images/icon_main_tab_third_selected.png')),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _pages = pages;
    _controller = PageController(initialPage: _currentIndex, keepPage: true);
  }

  @override
  Widget build(BuildContext context) {
    return DoubleBackTapExitApp(
      child: Scaffold(
        body: PageWidget(
          /// 禁止滑动
          physics: NeverScrollableScrollPhysics(),
          tabWidgets: _pages,
          controller: _controller,
          onPageChanged: _onPageChanged,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: tabList,
          currentIndex: _currentIndex,
          onTap: _onTabChanged,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didAppear() {
    super.didAppear();
  }

  @override
  void disappear() {
    super.disappear();
  }

  void _onPageChanged(int index) {}

  void _onTabChanged(int index) {
    jumpToIndex(index);
  }

  /// 跳到指定的Tab
  void jumpToIndex(int index) {
    setState(() {
      if (_currentIndex != index) {
        _currentIndex = index;
        _controller.jumpToPage(_currentIndex);
      }
    });
  }
}
```

The fragment code of Tab:

```dart
class FirstPage extends BaseTabPageWidget {
	@override
  int getIndex() {
    return 0;
  }
  
  @override
  void didAppear() {
    super.didAppear();
  }

  @override
  void disappear() {
    super.disappear();
  }

  @override
  void onForeground() {
    super.onForeground();
  }

  @override
  void onBackground() {
    super.onBackground();
  }
}
```



## Tips

- It is easy to use ,based on the NavigatorObserver implementation, maximum compatibility with the SDK version life cycle
- Life cycle methods are independent of each other,For example,when your application is switched to the background, the disAppear method will not be called, only onBackground will be called
- If your tab container does not extends BaseTabWidget, the life cycle of the fragment will not respond when switching to a normal page,it will only respond when switching internally
- The key to the fragment life cycle is the custom PageView component, which must be used,otherwise the life cycle will no longer respond when internal switching


