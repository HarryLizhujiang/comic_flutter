import 'dart:io';

import 'package:comic_flutter/http/Api.dart';
import 'package:comic_flutter/model/Comic.dart';
import 'package:comic_flutter/model/Serche.dart';
import 'package:comic_flutter/router/Navigator_util.dart';
import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate{
  @override
  String get searchFieldLabel => '搜索您想看的漫画吧！';
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center();
  }
  getData(String text){
    return API.getSerche(text);
  }
  @override
  Widget buildSuggestions(BuildContext context)  {
    return FutureBuilder(
      builder: _builderFuture,
      future: getData(query),
    );
  }
  Widget _builderFuture(BuildContext context, AsyncSnapshot snapshot){
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return Text('还没有开始网络请求');
      case ConnectionState.active:
        return Text('ConnectionState.active');
      case ConnectionState.waiting:
        return Center(
          child: CircularProgressIndicator(),
        );
      case ConnectionState.done:
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        return _createListView(context, snapshot);
      default:
        return null;
    }
  }
  Serche serche;
  Widget _createListView(BuildContext context,AsyncSnapshot snapshot){
     serche = snapshot.data;
     if(serche.sercheData.stateCode==0){
       return Center();
     }else{
       return ListView.builder(
         itemCount: serche.sercheData.returnData.length,
         itemBuilder: (context, index) => _itemBuilder(context,serche.sercheData.returnData[index]),
       );
     }
  }
  Widget _itemBuilder(BuildContext context,RData rData){
    return InkWell(
      child: ListTile(
        title: Text(rData.name),
      ),
      onTap: (){
        NavigatorUtil.goDetail(context, int.parse(rData.comicId));
      },
    );
  }
  
}