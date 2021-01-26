import 'package:example/pages/third_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lifecycle_base/tab/base_tab_page_widget.dart';

import '../fouth_page.dart';

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
    print("SecondPage回来了");
  }

  @override
  void disappear() {
    super.disappear();
    print("SecondPage消失了");
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
          child: RaisedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ThirdPage()));
            },
            child: Text("second_page"),
          )
      ),
    );
  }

  @override
  int getIndex() {
    return 1;
  }
}
