import 'dart:convert';

import 'package:comic_flutter/model/ComicHistory.dart';
import 'package:comic_flutter/pages/CustomSearchDelegate.dart';
import 'package:comic_flutter/router/Navigator_util.dart';
import 'package:comic_flutter/utils/storage.dart';
import 'package:comic_flutter/values/storages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoryPage();
  }
}

class _CategoryPage extends State<HistoryPage> {
  List<ComicHistory> historyList = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  /// 下拉刷新
  void _onRefresh() async {
    historyList = [];
    try {
      // 读取关注列表
      Map<String, dynamic> favorite =
          json.decode(StorageUtil().getJSON(COMIC_HISTORYID));
      if (favorite.isEmpty) {
        setState(() {
          historyList = null;
        });
      } else {
        favorite.forEach((key, value) {
          setState(() {
            historyList.add(ComicHistory.fromJson(value));
          });
        });
      }
    } catch (e) {
      print(e);
      _refreshController.refreshFailed();
    }
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
    // var favoriteJson = StorageUtil().getJSON(COMIC_HISTORYID);
    // if (favoriteJson != null) {
    //   Map<String, dynamic> favorite = json.decode(favoriteJson);
    //   favorite.forEach((key, value) {
    //     print(value);
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    if (historyList == null) {
      return Scaffold(
          appBar: AppBar(
            title: Text("观看历史"),
            centerTitle: true,
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                tooltip: "搜索",
                onPressed: () {
                  showSearch(
                      context: context, delegate: CustomSearchDelegate());
                },
              )
            ],
          ),
          body: SmartRefresher(
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: Center(
                child: Text("你没有观看过漫画哟！"),
              )));
    } else {
      return Scaffold(
          appBar: AppBar(
            title: Text("观看历史"),
            centerTitle: true,
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                tooltip: "搜索",
                onPressed: () {
                  showSearch(
                      context: context, delegate: CustomSearchDelegate());
                },
              )
            ],
          ),
          body: SmartRefresher(
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: historyList.length,
                itemBuilder: (context, index) {
                  return buildCard(historyList[index]);
                },
              )));
    }
  }

  Widget buildCard(ComicHistory historyList) {
    return GestureDetector(
      child: Row(
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(17),
              child: Image.network(
                historyList.cover,
                width: 80,
              )),
          Padding(padding: EdgeInsets.only(left: 16)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                historyList.comicName,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Text(
                historyList.chapterName,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
            ],
          ),
        ],
      ),
      onTap: () {
        NavigatorUtil.goContent(context, int.parse(historyList.chapterId),
            int.parse(historyList.comicId));
      },
    );
  }
}
