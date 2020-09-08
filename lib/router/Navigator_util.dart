import 'package:comic_flutter/router/Application.dart';
import 'package:comic_flutter/router/routers.dart';
import 'package:flutter/cupertino.dart';

class NavigatorUtil {
  static void goHome(BuildContext context) {
    Application.router.navigateTo(context, Routers.Home);
  }

  // ignore: non_constant_identifier_names
  static void goDetail(BuildContext context, int ComisId) {
    Application.router
        .navigateTo(context, Routers.Detail + "?comicid=$ComisId");
  }

  // ignore: non_constant_identifier_names
  static void goContent(BuildContext context, int ChapterId, int ComicId) {
    Application.router.navigateTo(
        context, Routers.Content + "?chapterid=$ChapterId&comicid=$ComicId");
  }
}
