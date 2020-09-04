import 'package:comic_flutter/router/router_handler.dart';
import 'package:fluro/fluro.dart';

class Routers{
  // 路由名称
  static String root = "/";
  static String Home = "/Home";
  static String Detail = "/Detail";
  static String Content = "/Content";

  static void configureRoutes(Router router) {
    router.define(root, handler: splashPageHanderl);
    router.define(Home,handler: HomePageHanderl);
    router.define(Detail, handler: DetailHanderl);
    router.define(Content, handler: ContentHanderl);
  }
}