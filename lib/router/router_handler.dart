import 'package:comic_flutter/pages/ComicDetailPage.dart';
import 'package:comic_flutter/pages/HomePage.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:comic_flutter/pages/SplashPage.dart';
import 'package:comic_flutter/pages/ContentPage.dart';

// 启动页
Handler splashPageHanderl = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return SplashPage();
  },
);
// 首页
// ignore: non_constant_identifier_names
Handler HomePageHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomePage();
});
// 详情页
Handler DetailHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  int ComicId = int.parse(params["comicid"].first);
  return ComicDetailPage(ComicId: ComicId);
});
// 内容
Handler ContentHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  int chapterId = int.parse(params["chapterid"].first);
  int comicId = int.parse(params["comicid"].first);
  return ContentPage(
    chapterId: chapterId,
    comicId: comicId,
  );
});
