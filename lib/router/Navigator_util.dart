import 'package:comic_flutter/model/ChapterList.dart';
import 'package:comic_flutter/router/Application.dart';
import 'package:comic_flutter/router/routers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

class NavigatorUtil{
  static void goHome(BuildContext context){
    Application.router.navigateTo(context, Routers.Home);
  }
  static void goDetail(BuildContext context,int ComisId){
    Application.router.navigateTo(context, Routers.Detail+"?comicid=$ComisId");
  }
  static void goContent(BuildContext context,int ChapterId,int ComicId){
    Application.router.navigateTo(context, Routers.Content+"?chapterid=$ChapterId&comicid=$ComicId");
  }

}