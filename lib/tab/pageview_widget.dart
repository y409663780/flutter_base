import 'package:flutter/material.dart';
import 'tab_navigator_manager.dart';

import '../navigator_manager.dart';

typedef PageChangedCallback = void Function(int index);

class PageWidget extends StatefulWidget {
  final List<Widget> tabWidgets;
  final PageController controller;
  final bool pageSnapping;
  final bool reverse;
  final ScrollPhysics physics;
  final PageChangedCallback onPageChanged;
  final Axis scrollDirection;

  PageWidget({
    Key key,
    this.controller,
    this.tabWidgets,
    this.pageSnapping = true,
    this.reverse = false,
    this.physics,
    this.onPageChanged,
    this.scrollDirection = Axis.horizontal,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => PageWidgetState();
}

class PageWidgetState extends State<PageWidget> {
  // int _prePageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        controller: widget.controller,
        itemCount: widget.tabWidgets.length,
        pageSnapping: widget.pageSnapping,
        reverse: widget.reverse,
        scrollDirection: widget.scrollDirection,
        physics: widget.physics,
        onPageChanged: (index) {
          TabNavigatorManager().isClick = true;
          print("PageView====${TabNavigatorManager().preIndex}===>$index");
          widget.onPageChanged(index);
          _onTabChanged(index);
         // TabNavigatorManager().preIndex = index;
        },
        itemBuilder: (context, index) {
          return widget.tabWidgets[index];
        });
  }

  void _onTabChanged(int index) {
    setState(() {
      if (TabNavigatorManager().preIndex != index) {
        widget.controller.jumpToPage(index);
        if (TabNavigatorManager()
            .isUseBaseTab(TabNavigatorManager().preIndex)) {
          TabNavigatorManager()
              .tabMap[TabNavigatorManager().preIndex]
              .disappear();
        }

        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (!TabNavigatorManager().isFirstLoad &&
              TabNavigatorManager()
                  .isUseBaseTab(index)) {
            TabNavigatorManager().tabMap[index].didAppear();
          }
        });
      }
      TabNavigatorManager().preIndex = index;
    });
  }
}
