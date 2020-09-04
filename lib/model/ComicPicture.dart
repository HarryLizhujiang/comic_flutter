class ComicPicture {
  PictureData pictureData;

  ComicPicture({this.pictureData});

  ComicPicture.fromJson(Map<String, dynamic> json) {
    pictureData = json['data'] != null
        ? new PictureData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pictureData != null) {
      data['data'] = this.pictureData.toJson();
    }
    return data;
  }
}

class PictureData {
  int stateCode;
  String message;
  ReturnData returnData;

  PictureData({this.stateCode, this.message, this.returnData});

  PictureData.fromJson(Map<String, dynamic> json) {
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
  String chapterId;
  String type;
  String zipFileHigh;
  List<ImageList> imageList;

  ReturnData(
      {this.chapterId,
        this.type,
        this.zipFileHigh,
        this.imageList,
      });

  ReturnData.fromJson(Map<String, dynamic> json) {
    chapterId = json['chapter_id'];
    type = json['type'];
    zipFileHigh = json['zip_file_high'];
    if (json['image_list'] != null) {
      imageList = new List<ImageList>();
      json['image_list'].forEach((v) {
        imageList.add(new ImageList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chapter_id'] = this.chapterId;
    data['type'] = this.type;
    data['zip_file_high'] = this.zipFileHigh;
    if (this.imageList != null) {
      data['image_list'] = this.imageList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImageList {
  String location;
  String imageId;
  String width;
  String height;
  String totalTucao;
  String webp;
  String type;
  String img05;
  String img50;
  List<Images> images;

  ImageList(
      {this.location,
        this.imageId,
        this.width,
        this.height,
        this.totalTucao,
        this.webp,
        this.type,
        this.img05,
        this.img50,
        this.images});

  ImageList.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    imageId = json['image_id'];
    width = json['width'];
    height = json['height'];
    totalTucao = json['total_tucao'];
    webp = json['webp'];
    type = json['type'];
    img05 = json['img05'];
    img50 = json['img50'];
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = this.location;
    data['image_id'] = this.imageId;
    data['width'] = this.width;
    data['height'] = this.height;
    data['total_tucao'] = this.totalTucao;
    data['webp'] = this.webp;
    data['type'] = this.type;
    data['img05'] = this.img05;
    data['img50'] = this.img50;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  String id;
  String sort;
  String width;
  String height;
  String img05;
  String img50;

  Images({this.id, this.sort, this.width, this.height, this.img05, this.img50});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sort = json['sort'];
    width = json['width'];
    height = json['height'];
    img05 = json['img05'];
    img50 = json['img50'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sort'] = this.sort;
    data['width'] = this.width;
    data['height'] = this.height;
    data['img05'] = this.img05;
    data['img50'] = this.img50;
    return data;
  }
}