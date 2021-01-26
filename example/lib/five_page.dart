import 'package:example/pages/second_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lifecycle_base/base_state_widget.dart';
import 'package:flutter_lifecycle_base/tab/base_tab_page_widget.dart';

class FifthPage extends BaseStatefulWidget {
  @override
  _FifthPageState createState() {
    return _FifthPageState();
  }
}

class _FifthPageState extends BaseWidgetState<FifthPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didAppear() {
    super.didAppear();
    pageLog("出现");
  }

  @override
  void disappear() {
    super.disappear();
    pageLog("消失");
  }

  @override
  void onBackground() {
    super.onBackground();
    pageLog("从前台到后台");
  }

  @override
  void onForeground() {
    super.onForeground();
    pageLog("从后台回来");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //   super.build(context);
    return Scaffold(
      body: Center(
        child: Text("fifth_page"),
      ),
    );
  }
//
//
//
//  @override
//  int getIndex() {
//    return 0;
//  }
}
