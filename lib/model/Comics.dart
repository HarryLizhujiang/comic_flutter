class Comics {
  int comicId;
  String cover;
  String name;
  int chapterCount;
  int lastUpdateTime;
  String seriesStatus;
  String description;
  String author;
  List<String> tags;

  Comics(
      {this.comicId,
        this.cover,
        this.name,
        this.chapterCount,
        this.lastUpdateTime,
        this.seriesStatus,
        this.description,
        this.author,
        this.tags});

  Comics.fromJson(Map<String, dynamic> json) {
    comicId = json['comic_id'];
    cover = json['cover'];
    name = json['name'];
    chapterCount = json['chapterCount'];
    lastUpdateTime = json['lastUpdateTime'];
    seriesStatus = json['series_status'];
    description = json['description'];
    author = json['author'];
    tags = json['tags'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comic_id'] = this.comicId;
    data['cover'] = this.cover;
    data['name'] = this.name;
    data['chapterCount'] = this.chapterCount;
    data['lastUpdateTime'] = this.lastUpdateTime;
    data['series_status'] = this.seriesStatus;
    data['description'] = this.description;
    data['author'] = this.author;
    data['tags'] = this.tags;
    return data;
  }
}