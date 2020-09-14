import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lifecycler_base/base_state_widget.dart';
import 'package:flutter_lifecycler_base/tab/base_tab_page_widget.dart';

class SecondPage extends BaseTabPageWidget {
  @override
  _SecondPageState createState() {
    return _SecondPageState();
  }
}

class _SecondPageState extends BaseTabPageState<SecondPage> {
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
  }

  @override
  void disappear() {
    super.disappear();
  }

  @override
  void onBackground() {
    super.onBackground();
  }

  @override
  void onForeground() {
    super.onForeground();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
        child: Text("second_page"),
      ),
    );
  }

  @override
  int getIndex() {
    return 1;
  }
}
