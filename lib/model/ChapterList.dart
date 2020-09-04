class ChapterList {
  String name;
  String imageTotal;
  String chapterId;
  var type;
  String price;
  String size;
  var passTime;
  String releaseTime;
  String zipHighWebp;
  int isNew;
  bool hasLockedImage;
  String index;

  ChapterList(
      {this.name,
        this.imageTotal,
        this.chapterId,
        this.type,
        this.price,
        this.size,
        this.passTime,
        this.releaseTime,
        this.zipHighWebp,
        this.isNew,
        this.hasLockedImage,
        this.index});

  ChapterList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageTotal = json['image_total'];
    chapterId = json['chapter_id'];
    type = json['type'];
    price = json['price'];
    size = json['size'];
    passTime = json['pass_time'];
    releaseTime = json['release_time'];
    zipHighWebp = json['zip_high_webp'];
    isNew = json['is_new'];
    hasLockedImage = json['has_locked_image'];
    index = json['index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image_total'] = this.imageTotal;
    data['chapter_id'] = this.chapterId;
    data['type'] = this.type;
    data['price'] = this.price;
    data['size'] = this.size;
    data['pass_time'] = this.passTime;
    data['release_time'] = this.releaseTime;
    data['zip_high_webp'] = this.zipHighWebp;
    data['is_new'] = this.isNew;
    data['has_locked_image'] = this.hasLockedImage;
    data['index'] = this.index;
    return data;
  }
}