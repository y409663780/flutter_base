import 'package:exmaple/fouth_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lifecycler_base/tab/base_tab_page_widget.dart';

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
