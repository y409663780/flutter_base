import 'package:exmaple/pages/first_page.dart';
import 'package:exmaple/pages/second_page.dart';
import 'package:exmaple/pages/third_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lifecycler_base/tab/base_tab_widget.dart';
import 'package:flutter_lifecycler_base/tab/pageview_widget.dart';

import 'main_double_back_tap_exit_app.dart';

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
