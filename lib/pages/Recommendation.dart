import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ComicPage.dart';
import 'CustomSearchDelegate.dart';

class Recommendation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Recommendation();
  }
}

class _Recommendation extends State<Recommendation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0),
      appBar: AppBar(
        title: Text("所有漫画"),
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
      body: ComicPage(),
    );
  }
}
