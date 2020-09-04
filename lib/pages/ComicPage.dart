import 'package:comic_flutter/http/Api.dart';
import 'package:comic_flutter/model/Comic.dart';
import 'package:comic_flutter/model/Comics.dart';
import 'package:comic_flutter/router/Navigator_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ComicPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ComicPage();
  }
}

class _ComicPage extends State<ComicPage> {
  Comic comic;
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  int pageNum = 1;
  @override
  void initState() {
    getData(pageNum);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void getData(pageNum) {
    API.getComicList(pageNum).then((value) => {
          setState(() {
            comic = value;
          })
        });
  }

  // 下拉刷新
  void _onRefresh() async {
    try {
      getData(pageNum);
      if (comic.comicData != null) {
        _refreshController.refreshCompleted();
      }
    } catch (e) {
      _refreshController.refreshFailed();
    }
  }

  Comic comic1;
  // 上拉加载
  void _onLoading() async {
    comic1 = await API.getComicList(pageNum + 1);
    setState(() {
      pageNum++;
      try {
        comic.comicData.returnData.comics
            .addAll(comic1.comicData.returnData.comics);
      } catch (e) {
        comic1 = null;
      }
    });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    if (comic == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    // TODO: implement build
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus mode) {
          if (pageNum != 1) {
            if (comic1 == null) {
              mode = null;
            }
          }

          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text("上拉加载");
          } else if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          } else if (mode == LoadStatus.canLoading) {
            body = Text("准备好了放手吧！！");
          } else {
            body = Text("别拉了没有了！！");
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      child: GridView.builder(
        padding: EdgeInsets.all(7),
        primary: false,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.6),
        itemCount: comic.comicData.returnData.comics.length,
        itemBuilder: (context, index) {
          return buildCard(comic.comicData.returnData.comics[index]);
        },
      ),
    );
  }

  buildCard(Comics comics) {
    var controller = new Container(
        child: Column(
      children: <Widget>[
        Container(
          height: 170,
          child: Image.network(
            comics.cover,
            fit: BoxFit.fill,
          ),
        ),
        Container(
          width: 150,
          alignment: Alignment.center,
          child: Text(
            comics.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    ));
    return Card(
      child: InkWell(
        onTap: () {
          NavigatorUtil.goDetail(context, comics.comicId);
        },
        child: Column(
          children: <Widget>[controller],
        ),
      ),
    );
  }
}
