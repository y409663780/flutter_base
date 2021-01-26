import 'package:example/five_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lifecycle_base/base_state_widget.dart';

class FourthPage extends BaseStatefulWidget {
  @override
  _FourthPagePageState createState() {
    return _FourthPagePageState();
  }
}

class _FourthPagePageState extends BaseWidgetState<FourthPage> {
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
    print("FourthPage回来了");
  }

  @override
  void disappear() {
    super.disappear();
    print("FourthPage消失了");
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
    return Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => FifthPage()));
          },
          child: Text("FourthPage"),
        )
    );
  }
}
