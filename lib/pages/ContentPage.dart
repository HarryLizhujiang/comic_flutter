import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:comic_flutter/http/Api.dart';
import 'package:comic_flutter/model/ChapterList.dart';
import 'package:comic_flutter/model/ComicHistory.dart';
import 'package:comic_flutter/model/ComicPicture.dart';
import 'package:comic_flutter/model/DComic.dart';
import 'package:comic_flutter/utils/storage.dart';
import 'package:comic_flutter/utils/toast.dart';
import 'package:comic_flutter/values/storages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ContentPage extends StatefulWidget {
  final int chapterId;
  final int comicId;
  ContentPage({@required this.chapterId, this.comicId});
  @override
  State<StatefulWidget> createState() {
    return _Cantent();
  }
}

class _Cantent extends State<ContentPage> {
  List<ChapterList> chapterList;
  List<ImageList> imageList;
  DComic dComic;
  // ignore: non_constant_identifier_names
  var Code;
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    ComicHistory comicHistory = new ComicHistory();
    comicHistory.comicId = dComic.comicId;
    comicHistory.comicName = dComic.name;
    comicHistory.chapterId = chapterList[index].chapterId;
    comicHistory.chapterName = chapterList[index].name;
    comicHistory.cover = dComic.cover;
    // 保存历史记录
    var favoriteJson = StorageUtil().getJSON(COMIC_HISTORYID);
    Map<String, dynamic> favorite;
    if (favoriteJson != null) {
      favorite = json.decode(favoriteJson);
      favorite.forEach((key, value) {
        if (key == comicHistory.comicId) {
          StorageUtil().remove(key);
        }
      });
    } else {
      favorite = Map<String, dynamic>();
    }
    favorite.addAll({comicHistory.comicId: comicHistory});
    StorageUtil().setJSON(COMIC_HISTORYID, json.encode(favorite));
    String comicName = dComic.name;
    String chapterName = chapterList[index].name;
    print("漫画名称$comicName,章节名称$chapterName");
    _refreshController.dispose();
    super.dispose();
  }

  void getData() {
    API.getComicDetail(widget.comicId).then((value) => {
          setState(() {
            chapterList = value.comicDetailData.returnData.chapterList;
            dComic = value.comicDetailData.returnData.Dcomic;
          })
        });
    API.getPicture(widget.chapterId).then((value) => {
          setState(() {
            imageList = value.pictureData.returnData.imageList;
          })
        });
  }

  int index = 0;
  // 上拉加载
  void _onLoading() async {
    if (index == 0) {
      print("上拉加载");
      for (int i = 0; i < chapterList.length; i++) {
        if (int.parse(chapterList[i].chapterId) == widget.chapterId) {
          index = i + 1;
        }
      }
      API.getPicture(int.parse(chapterList[index].chapterId)).then((value) => {
            setState(() {
              imageList.addAll(value.pictureData.returnData.imageList);
            })
          });
    } else {
      index++;
      API.getPicture(int.parse(chapterList[index].chapterId)).then((value) => {
            setState(() {
              imageList.addAll(value.pictureData.returnData.imageList);
            })
          });
    }
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    if (imageList == null) {
      if (Code == -4) {
        showToast("此章节为收费章节！见谅");
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return SmartRefresher(
      enablePullDown: false,
      enablePullUp: true,
      controller: _refreshController,
      onLoading: _onLoading,
      footer: ClassicFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        loadingText: "Loading",
      ),
      child: ListView.builder(
        itemCount: imageList.length,
        itemBuilder: (BuildContext context, int index) {
          return textField(context, imageList[index], index);
        },
      ),
    );
  }

  Widget textField(BuildContext context, ImageList imageList, int index) {
    index++;
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: imageList.location,
            placeholder: (context, url) => CircularProgressIndicator(
              backgroundColor: Colors.grey,
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Container(
            width: width,
            decoration: new BoxDecoration(
              color: Colors.white,
            ),
            child: Text(
              "第$index页",
              style: TextStyle(fontSize: 8, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
