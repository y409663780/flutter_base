import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lifecycle_base/tab/base_tab_page_widget.dart';

import '../fouth_page.dart';

class FirstPage extends BaseTabPageWidget {
  @override
  _FirstPageState createState() {
    return _FirstPageState();
  }
}

class _FirstPageState extends BaseTabPageState<FirstPage> {
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
    print("FirstPage回来了");
  }

  @override
  void disappear() {
    super.disappear();
    print("FirstPage回来了");
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
    super.build(context);
    return Scaffold(
      body: Center(
          child: RaisedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => FourthPage()));
            },
            child: Text("first_page"),
          )
      ),
    );
  }



  @override
  int getIndex() {
    return 0;
  }
}
