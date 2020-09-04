import 'ComicDetail.dart';

class DComic {
  String name;
  String comicId;
  String shortDescription;
  int accredit;
  String cover;
  var isVip;
  String type;
  String ori;
  List<String> themeIds;
  int seriesStatus;
  int lastUpdateTime;
  String description;
  String cateId;
  String weekMore;
  int status;
  String threadId;
  String lastUpdateWeek;
  String wideCover;
  List<ClassifyTags> classifyTags;
  Author author;
  List<String> tagList;

  DComic(
      {this.name,
        this.comicId,
        this.shortDescription,
        this.accredit,
        this.cover,
        this.isVip,
        this.type,
        this.ori,
        this.themeIds,
        this.seriesStatus,
        this.lastUpdateTime,
        this.description,
        this.cateId,
        this.weekMore,
        this.status,
        this.threadId,
        this.lastUpdateWeek,
        this.wideCover,
        this.classifyTags,
        this.author,
        this.tagList});

  DComic.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    comicId = json['comic_id'];
    shortDescription = json['short_description'];
    accredit = json['accredit'];
    cover = json['cover'];
    isVip = json['is_vip'];
    type = json['type'];
    ori = json['ori'];
    themeIds = json['theme_ids'].cast<String>();
    seriesStatus = json['series_status'];
    lastUpdateTime = json['last_update_time'];
    description = json['description'];
    cateId = json['cate_id'];
    weekMore = json['week_more'];
    status = json['status'];
    threadId = json['thread_id'];
    lastUpdateWeek = json['last_update_week'];
    wideCover = json['wideCover'];
    if (json['classifyTags'] != null) {
      classifyTags = new List<ClassifyTags>();
      json['classifyTags'].forEach((v) {
        classifyTags.add(new ClassifyTags.fromJson(v));
      });
    }
    author =
    json['author'] != null ? new Author.fromJson(json['author']) : null;
    tagList = json['tagList'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['comic_id'] = this.comicId;
    data['short_description'] = this.shortDescription;
    data['accredit'] = this.accredit;
    data['cover'] = this.cover;
    data['is_vip'] = this.isVip;
    data['type'] = this.type;
    data['ori'] = this.ori;
    data['theme_ids'] = this.themeIds;
    data['series_status'] = this.seriesStatus;
    data['last_update_time'] = this.lastUpdateTime;
    data['description'] = this.description;
    data['cate_id'] = this.cateId;
    data['week_more'] = this.weekMore;
    data['status'] = this.status;
    data['thread_id'] = this.threadId;
    data['last_update_week'] = this.lastUpdateWeek;
    data['wideCover'] = this.wideCover;
    if (this.classifyTags != null) {
      data['classifyTags'] = this.classifyTags.map((v) => v.toJson()).toList();
    }
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    data['tagList'] = this.tagList;
    return data;
  }
}