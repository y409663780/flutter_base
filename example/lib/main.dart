import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lifecycle_base/base_state_widget.dart';

import 'main_bottom_tab.dart';

void main() {
  runApp(MyApp());

  ///状态栏全局透明
  SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

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

class MyHomePage extends BaseStatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends BaseWidgetState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MainBottomTabView()));
          },
          child: Text("跳转到Tab页面"),
        ),
      ),
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
  void onBackground() {
    super.onBackground();
  }

  @override
  void onForeground() {
    super.onForeground();
  }
}
