import 'package:comic_flutter/model/Comic.dart';
import 'package:comic_flutter/model/ComicDetail.dart';
import 'package:comic_flutter/model/ComicPicture.dart';
import 'package:comic_flutter/model/Serche.dart';
import 'package:flutter/material.dart';

import 'dio_util.dart';

class API {
  // 漫画列表
  static String listS = "/list/conditionScreenlists";
  // 漫画详情
  static String detailS = "/comic/detail_static_new";
  //章节图片
  static String ChapterS = "/comic/chapterNew";
  //搜索漫画
  static String SercheS = "/search/relative?inputText=鬼";



  // 漫画列表
  static Future<Comic> getComicList(int pageNum) async {
    var jsonData = await HttpManager.getInstance().get(listS,params: {"page":pageNum,"v":"5300100"});
    return Comic.fromJson(jsonData);
  }
  // 漫画详情
  static Future<ComicDetail> getComicDetail(int ComicId) async{
    var jsonData = await HttpManager.getInstance().get(detailS,params: {"comicid":ComicId});
    return ComicDetail.fromJson(jsonData);
  }
  // 漫画图片
  static Future<ComicPicture> getPicture(int ChapterId) async{
    var jsonData = await HttpManager.getInstance().get(ChapterS,params: {"chapter_id":ChapterId});
    return ComicPicture.fromJson(jsonData);
  }
  static Future<Serche> getSerche(String Text) async{
    var jsonData = await HttpManager.getInstance().get(SercheS,params: {"inputText":Text});
    return Serche.fromJson(jsonData);
  }
}
