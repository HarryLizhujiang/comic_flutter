// ignore: must_be_immutable
import 'dart:convert';

import 'package:comic_flutter/http/Api.dart';
import 'package:comic_flutter/model/ChapterList.dart';
import 'package:comic_flutter/model/ComicDetail.dart';
import 'package:comic_flutter/model/DComic.dart';
import 'package:comic_flutter/router/Navigator_util.dart';
import 'package:comic_flutter/utils/toast.dart';
import 'package:comic_flutter/values/storages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:comic_flutter/utils/storage.dart';

class ComicDetailPage extends StatefulWidget {
  int ComicId;

  ComicDetailPage({@required this.ComicId});

  @override
  State<StatefulWidget> createState() {
    return _ComicDetailpage();
  }
}

class _ComicDetailpage extends State<ComicDetailPage> {
  ScrollController _scrollController;
  VoidCallback onChange;
  ComicDetail comicDetail;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    onChange = () {
      print('onChange');
    };
    _scrollController.addListener(onChange);
    getData();
    //判断是否关注房间
    var favoriteJson = StorageUtil().getJSON(COMIC_ID);
    if (favoriteJson != null) {
      Map<String, dynamic> favorite = json.decode(favoriteJson);
      favorite.forEach((key, value) {
        if (int.parse(key) == widget.ComicId) {
          setState(() {
            isFavorite = true;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    comicDetail = null;
    super.dispose();
  }

  void getData() {
    API.getComicDetail(widget.ComicId).then((value) => {
          setState(() {
            comicDetail = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    if (comicDetail == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
//      appBar: AppBar(
//        centerTitle: true,
//        title: Text(comicDetail.comicDetailData.returnData.Dcomic.name),
//      ),
      body: DetailBody(comicDetail.comicDetailData.returnData.Dcomic,isFavorite),
    );
  }

  Widget DetailBody(DComic comic,bool isFavorite) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: true,
          delegate: SliverCustomHeaderDelegate(
              title: comic.name,
              collapsedHeight: 40,
              expandedHeight: 250,
              paddingTop: MediaQuery.of(context).padding.top,
              coverImgUrl: comic.wideCover==null?"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3522153331,2005539188&fm=26&gp=0.jpg":comic.wideCover
          ),
        ),
        SliverFillRemaining(
          child: FilmContent(comic, comicDetail.comicDetailData.returnData.chapterList,isFavorite),
        )
      ],
    );
  }
}

class FilmContent extends StatefulWidget {
  DComic comic;
  List<ChapterList> chapterList;
  bool isFavorite;
  FilmContent(
      this.comic,
      this.chapterList,
      this.isFavorite,
  );

  @override
  State<StatefulWidget> createState() {
    return _FilmContent(comic,chapterList,isFavorite);
  }
}
class _FilmContent extends State<FilmContent>{
  DComic comic;
  //是否关注
  bool isFavorite;
  List<ChapterList> chapterList;
  _FilmContent(
      this.comic,
      this.chapterList,
      this.isFavorite
      );

  // 漫画详细信息
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // 漫画信息
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: 130,
                height: 180,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: NetworkImage(comic.cover)
                    )
                )
            ),

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
                ComicType(),
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
        Divider(height: 32),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  '简介',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(271, 0, 0, 0),
                  child: IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: isFavorite ? Colors.pink : Colors.grey[400],
                      ),
                      onPressed: favoriteOrCancel
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text(
              comic.description,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF999999),
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            Divider(height: 32),
            // 章节信息
            Row(
              children: <Widget>[
                Text(
                  '章节',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                Expanded(
                  child: Text(''), // 中间用Expanded控件
                ),
                GestureDetector(
                  child: Text(
                    "全部章节",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF999999),
                    ),
                  ),
                  onTap: () {
                    //点击全部章节触发的事件
                    // 改了源码的最大高度
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return new AnimatedPadding(
                              padding: MediaQuery.of(context).viewInsets,
                              duration: const Duration(milliseconds: 100),
                              child: Container(
                                  child: ListView.builder(
                                    itemCount: chapterList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return textField(context,chapterList[index]);
                                    },
                                  )));
                        });
                  },
                )
              ],
            ),
            GestureDetector(
              // 此页面只显示一个章节
              child: Row(
                children: <Widget>[
                  // 章节图片
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                    width: 150,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(comic.wideCover==null?"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3522153331,2005539188&fm=26&gp=0.jpg":comic.wideCover, fit: BoxFit.cover,),
                    ),
                  ),
                  // 章节文字
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 200,
                        child: Text(
                          chapterList[0].name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),

                      Text(
                        getUpdataTiem(chapterList[0].passTime),
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF999999),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              onTap: (){
                NavigatorUtil.goContent(context, int.parse(chapterList[0].chapterId),int.parse(comic.comicId));
              },
            )
          ],
        ),
      ],
    ),
    );
  }
  // 关注处理
  favoriteOrCancel(){
    setState(() {
      isFavorite = !isFavorite;
    });
    //读取关注列表
    var favoriteJson = StorageUtil().getJSON(COMIC_ID);
    Map<String, dynamic> favorite;

    if (isFavorite) {
      if (favoriteJson != null) {
        favorite = json.decode(favoriteJson);
      } else {
        favorite = Map<String, dynamic>();
      }
      favorite.addAll({comic.comicId:comic});
      showToast("关注成功");
    } else {
      favorite = json.decode(favoriteJson);
      favorite.remove(comic.comicId);
      showToast("取关成功");
    }
    StorageUtil().setJSON(COMIC_ID, json.encode(favorite));
  }
  // 漫画类型处理
  Widget ComicType() {
    List<Widget> list = [];
    Widget w;
    for (int i = 0; i < comic.classifyTags.length; i++) {
      list.add(new Container(
          height: 20,
          width: 40,
          alignment: Alignment(0, 0),
          margin: EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: new Border.all(width: 1, color: Colors.grey),
          ),
          child: Text(
            comic.classifyTags[i].name,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF999999),
            ),
          )));
    }
    w = new Row(
      children: list,
    );
    return w;
  }

  // 处理时间戳
  String getUpdataTiem(var lastUpdateTime) {
    String createtime = lastUpdateTime.toString() + "000";
    DateTime createTime =
    DateTime.fromMillisecondsSinceEpoch(int.parse(createtime));
    createtime = createTime.toLocal().toString().substring(0, 19);
    return createtime;
  }

  // 全部章节列表
  textField(BuildContext context, ChapterList chapter) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          // 边框
            border: Border.all(
              // 颜色
                color: Colors.grey,
                // 线条宽度
                width: 0.5)),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              width: 150,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage.assetNetwork(
                  placeholder: comic.wideCover==null?"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3522153331,2005539188&fm=26&gp=0.jpg":comic.wideCover,
                  image: comic.wideCover==null?"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3522153331,2005539188&fm=26&gp=0.jpg":comic.wideCover,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 220,
                  child: Text(
                    chapter.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  getUpdataTiem(chapterList[0].passTime),
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF999999),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: (){
        NavigatorUtil.goContent(context, int.parse(chapter.chapterId),int.parse(comic.comicId));
      },
    );
  }

}

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;
  final String coverImgUrl;
  final String title;
  String statusBarMode = 'dark';

  SliverCustomHeaderDelegate({
    this.collapsedHeight,
    this.expandedHeight,
    this.paddingTop,
    this.coverImgUrl,
    this.title,
  });

  @override
  double get minExtent => this.collapsedHeight + this.paddingTop;

  @override
  double get maxExtent => this.expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  void updateStatusBarBrightness(shrinkOffset) {
    if (shrinkOffset > 50 && this.statusBarMode == 'dark') {
      this.statusBarMode = 'light';
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ));
    } else if (shrinkOffset <= 50 && this.statusBarMode == 'light') {
      this.statusBarMode = 'dark';
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ));
    }
  }

  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
        .clamp(0, 255)
        .toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    if (shrinkOffset <= 50) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
          .clamp(0, 255)
          .toInt();
      return Color.fromARGB(alpha, 0, 0, 0);
    }
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    this.updateStatusBarBrightness(shrinkOffset);
    return Container(
      height: this.maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(child: Image.network(this.coverImgUrl, fit: BoxFit.cover)),
          Positioned(
            left: 0,
            top: this.maxExtent / 2,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x00000000),
                    Color(0x90000000),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              color: this.makeStickyHeaderBgColor(shrinkOffset),
              child: SafeArea(
                bottom: false,
                child: Container(
                  height: this.collapsedHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: this
                              .makeStickyHeaderTextColor(shrinkOffset, true),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        this.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: this
                              .makeStickyHeaderTextColor(shrinkOffset, false),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          color: this
                              .makeStickyHeaderTextColor(shrinkOffset, true),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
