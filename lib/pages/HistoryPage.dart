import 'package:comic_flutter/pages/CustomSearchDelegate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoryPage();
  }
}

class _CategoryPage extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
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
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
          )
        ],
      ),
      body: Center(
        child: Text("待开发见谅！"),
      ),
    );
  }
}
