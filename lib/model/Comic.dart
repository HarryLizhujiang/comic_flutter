import 'Comics.dart';

class Comic {
  ComicData comicData;

  Comic({this.comicData});

  Comic.fromJson(Map<String, dynamic> json) {
    comicData = json['data'] != null
        ? new ComicData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.comicData != null) {
      data['data'] = this.comicData.toJson();
    }
    return data;
  }
}

class ComicData {
  int stateCode;
  String message;
  ReturnData returnData;

  ComicData({this.stateCode, this.message, this.returnData});

  ComicData.fromJson(Map<String, dynamic> json) {
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
  List<EditParams> editParams;
  List<Comics> comics;
  bool hasMore;
  int page;

  ReturnData({this.editParams, this.comics, this.hasMore, this.page});

  ReturnData.fromJson(Map<String, dynamic> json) {
    if (json['editParams'] != null) {
      editParams = new List<EditParams>();
      json['editParams'].forEach((v) {
        editParams.add(new EditParams.fromJson(v));
      });
    }
    if (json['comics'] != null) {
      comics = new List<Comics>();
      json['comics'].forEach((v) {
        comics.add(new Comics.fromJson(v));
      });
    }
    hasMore = json['hasMore'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.editParams != null) {
      data['editParams'] = this.editParams.map((v) => v.toJson()).toList();
    }
    if (this.comics != null) {
      data['comics'] = this.comics.map((v) => v.toJson()).toList();
    }
    data['hasMore'] = this.hasMore;
    data['page'] = this.page;
    return data;
  }
}

class EditParams {
  String title;
  List<MenuItemList> menuItemList;

  EditParams({this.title, this.menuItemList});

  EditParams.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['menuItemList'] != null) {
      menuItemList = new List<MenuItemList>();
      json['menuItemList'].forEach((v) {
        menuItemList.add(new MenuItemList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.menuItemList != null) {
      data['menuItemList'] = this.menuItemList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MenuItemList {
  String name;
  String argNameKey;
  String argName;
  String argValKey;
  int argVal;

  MenuItemList(
      {this.name, this.argNameKey, this.argName, this.argValKey, this.argVal});

  MenuItemList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    argNameKey = json['argNameKey'];
    argName = json['argName'];
    argValKey = json['argValKey'];
    argVal = int.parse(json['argVal'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['argNameKey'] = this.argNameKey;
    data['argName'] = this.argName;
    data['argValKey'] = this.argValKey;
    data['argVal'] = this.argVal;
    return data;
  }
}

