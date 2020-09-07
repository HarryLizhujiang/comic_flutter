import 'dart:convert';

import 'package:comic_flutter/model/DComic.dart';
import 'package:comic_flutter/router/Navigator_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'CustomSearchDelegate.dart';
import 'package:comic_flutter/utils/storage.dart';
import 'package:comic_flutter/values/storages.dart';

class FollowPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FollowPage();
  }
}

class _FollowPage extends State<FollowPage> {
  List<DComic> comiclist = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  @override
  void initState() {
    super.initState();
    // // 读取关注列表
    // Map<String, dynamic> favorite =
    //     json.decode(StorageUtil().getJSON(COMIC_ID));
    // favorite.forEach((key, value) {
    //   comiclist.add(DComic.fromJson(value));
    // });
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  /// 下拉刷新
  void _onRefresh() async {
    comiclist = [];
    try {
      // 读取关注列表
      Map<String, dynamic> favorite =
          json.decode(StorageUtil().getJSON(COMIC_ID));
      if (favorite.isEmpty) {
        setState(() {
          comiclist = null;
        });
      } else {
        favorite.forEach((key, value) {
          setState(() {
            comiclist.add(DComic.fromJson(value));
          });
        });
      }
    } catch (e) {
      print(e);
      print("object");
      _refreshController.refreshFailed();
    }
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    if (comiclist == null) {
      return Scaffold(
          appBar: AppBar(
            title: Text("书架"),
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
                child: Text("你还没有关注的漫画哟！"),
              )));
    } else {
      return Scaffold(
          appBar: AppBar(
            title: Text("书架"),
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
                itemCount: comiclist.length,
                itemBuilder: (context, index) {
                  return buildCard(comiclist[index]);
                },
              )));
    }
  }

  DComic comic;
  buildCard(DComic comic) {
    comic = comic;
    return GestureDetector(
      child: Row(
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(17),
              child: Image.network(
                comic.cover,
                width: 150,
              )),
          Padding(padding: EdgeInsets.only(left: 16)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                comic.name,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                children: <Widget>[
                  ClipOval(
                    child: Image.network(
                      comic.author.avatar,
                      height: 30,
                      width: 30,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 5)),
                  Text(
                    comic.author.name,
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF999999),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 2)),
              Text(
                comic.shortDescription,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF999999),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 2)),
              Text(
                '更新时间：' + getUpdataTiem(comic.lastUpdateTime),
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF999999),
                ),
              ),
            ],
          ),
        ],
      ),
      onTap: () {
        NavigatorUtil.goDetail(context, int.parse(comic.comicId));
      },
    );
  }

  // 处理时间戳
  String getUpdataTiem(var lastUpdateTime) {
    String createtime = lastUpdateTime.toString() + "000";
    DateTime createTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(createtime));
    createtime = createTime.toLocal().toString().substring(0, 19);
    return createtime;
  }
}
