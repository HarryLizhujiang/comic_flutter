import 'dart:convert';
import 'package:comic_flutter/config/global.dart';
import 'package:comic_flutter/model/DComic.dart';
import 'package:comic_flutter/pages/SplashPage.dart';
import 'package:comic_flutter/router/Application.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:comic_flutter/router/routers.dart';
import 'package:comic_flutter/utils/storage.dart';
import 'package:comic_flutter/values/storages.dart';

void main() => Global.init().then((e) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Comic', debugShowCheckedModeBanner: false, home: SplashPage());
  }
}
