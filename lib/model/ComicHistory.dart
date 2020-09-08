class ComicHistory {
  String comicId;
  String comicName;
  String chapterId;
  String chapterName;
  String cover;
  ComicHistory(
      {this.comicId,
      this.comicName,
      this.chapterId,
      this.chapterName,
      this.cover});
  ComicHistory.fromJson(Map<String, dynamic> json) {
    comicId = json['comic_id'];
    comicName = json['comic_name'];
    chapterId = json['chapter_id'];
    chapterName = json['chapter_name'];
    cover = json['cover'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comic_id'] = this.comicId;
    data['comic_name'] = this.comicName;
    data['chapter_id'] = this.chapterId;
    data['chapter_name'] = this.chapterName;
    data['cover'] = this.cover;
    return data;
  }
}
