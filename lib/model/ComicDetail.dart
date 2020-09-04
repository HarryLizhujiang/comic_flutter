import 'ChapterList.dart';
import 'DComic.dart';

class ComicDetail {
  ComicDetailData comicDetailData;

  ComicDetail({this.comicDetailData});

  ComicDetail.fromJson(Map<String, dynamic> json) {
    comicDetailData = json['data'] != null
        ? new ComicDetailData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.comicDetailData != null) {
      data['data'] = this.comicDetailData.toJson();
    }
    return data;
  }
}

class ComicDetailData {
  int stateCode;
  String message;
  ReturnData returnData;

  ComicDetailData({this.stateCode, this.message, this.returnData});

  ComicDetailData.fromJson(Map<String, dynamic> json) {
    stateCode = json['stateCode'];
    message = json['message'];
    returnData = json['returnData'] != null
        ? new ReturnData.fromJson(json['returnData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stateCode'] = this.stateCode;
    data['message'] = this.message;
    if (this.returnData != null) {
      data['returnData'] = this.returnData.toJson();
    }
    return data;
  }
}

class ReturnData {
  DComic Dcomic;
  List<ChapterList> chapterList;
  List<OtherWorks> otherWorks;
  ReturnData({this.Dcomic, this.chapterList, this.otherWorks});

  ReturnData.fromJson(Map<String, dynamic> json) {
    Dcomic = json['comic'] != null ? new DComic.fromJson(json['comic']) : null;
    if (json['chapter_list'] != null) {
      chapterList = new List<ChapterList>();
      json['chapter_list'].forEach((v) {
        chapterList.add(new ChapterList.fromJson(v));
      });
    }
    if (json['otherWorks'] != null) {
      otherWorks = new List<OtherWorks>();
      json['otherWorks'].forEach((v) {
        otherWorks.add(new OtherWorks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.Dcomic != null) {
      data['comic'] = this.Dcomic.toJson();
    }
    if (this.chapterList != null) {
      data['chapter_list'] = this.chapterList.map((v) => v.toJson()).toList();
    }
    if (this.otherWorks != null) {
      data['otherWorks'] = this.otherWorks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClassifyTags {
  String name;
  String argName;
  int argVal;

  ClassifyTags({this.name, this.argName, this.argVal});

  ClassifyTags.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    argName = json['argName'];
    argVal = json['argVal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['argName'] = this.argName;
    data['argVal'] = this.argVal;
    return data;
  }
}

class Author {
  String avatar;
  String name;
  String id;

  Author({this.avatar, this.name, this.id});

  Author.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}

class OtherWorks {
  String comicId;
  String coverUrl;
  String name;
  String passChapterNum;

  OtherWorks({this.comicId, this.coverUrl, this.name, this.passChapterNum});

  OtherWorks.fromJson(Map<String, dynamic> json) {
    comicId = json['comicId'];
    coverUrl = json['coverUrl'];
    name = json['name'];
    passChapterNum = json['passChapterNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comicId'] = this.comicId;
    data['coverUrl'] = this.coverUrl;
    data['name'] = this.name;
    data['passChapterNum'] = this.passChapterNum;
    return data;
  }
}
