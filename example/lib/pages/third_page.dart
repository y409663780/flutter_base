
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lifecycle_base/tab/base_tab_page_widget.dart';

import '../fouth_page.dart';

class ThirdPage extends BaseTabPageWidget {
  @override
  _ThirdPageState createState() {
    return _ThirdPageState();
  }
}

class _ThirdPageState extends BaseTabPageState<ThirdPage> {
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
    print("ThirdPage回来了");
  }

  @override
  void disappear() {
    super.disappear();
    print("ThirdPage消失了");
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
                  .push(MaterialPageRoute(builder: (context) => FourthPage()));
            },
            child: Text("third_page"),
          )
      ),
    );
  }

  @override
  int getIndex() {
    return 2;
  }
}
