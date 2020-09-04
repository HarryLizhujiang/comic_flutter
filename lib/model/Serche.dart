class Serche {
  SercheData sercheData;

  Serche({this.sercheData});

  Serche.fromJson(Map<String, dynamic> json) {
    sercheData = json['data'] != null
        ? new SercheData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sercheData != null) {
      data['data'] = this.sercheData.toJson();
    }
    return data;
  }
}

class SercheData {
  int stateCode;
  String message;
  List<RData> returnData;

  SercheData({this.stateCode, this.message, this.returnData});

  SercheData.fromJson(Map<String, dynamic> json) {
    stateCode = json['stateCode'];
    message = json['message'];
    if (json['returnData'] != null) {
      returnData = new List<RData>();
      json['returnData'].forEach((v) {
        returnData.add(new RData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stateCode'] = this.stateCode;
    data['message'] = this.message;
    if (this.returnData != null) {
      data['returnData'] = this.returnData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RData {
  String comicId;
  String name;

  RData({this.comicId, this.name});

  RData.fromJson(Map<String, dynamic> json) {
    comicId = json['comic_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comic_id'] = this.comicId;
    data['name'] = this.name;
    return data;
  }
}