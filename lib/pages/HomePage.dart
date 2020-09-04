import 'package:comic_flutter/pages/HistoryPage.dart';
import 'package:comic_flutter/router/Navigator_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'FollowPage.dart';
import 'MyPage.dart';
import 'Recommendation.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}
class _HomePage extends State<HomePage>{
  int _currentIndex = 0;
  List<Widget> _pageList = [
    Recommendation(),
    HistoryPage(),
    FollowPage(),
    MyPage()
  ];
  List<BottomNavigationBarItem> _barItem = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        title: Container()),
    BottomNavigationBarItem(icon: Icon(Icons.history), title: Container()),
    BottomNavigationBarItem(icon: Icon(Icons.collections_bookmark), title: Container()),
    BottomNavigationBarItem(icon: Icon(Icons.code), title: Container()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: this._pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index){
          setState(() {
            this._currentIndex = index;
          });
        },
        currentIndex: this._currentIndex,
        items: _barItem,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}