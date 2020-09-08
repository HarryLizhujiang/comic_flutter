import 'package:comic_flutter/config/global.dart';
import 'package:comic_flutter/pages/SplashPage.dart';
import 'package:flutter/material.dart';

void main() => Global.init().then((e) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comic',
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
