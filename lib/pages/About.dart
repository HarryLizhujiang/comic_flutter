import 'package:comic_flutter/pages/CustomSearchDelegate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _About();
  }
}

class _About extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("关于APP"),
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
        body: Container(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    'APP说明：关于《快看漫画》APP是一枚热爱编程，热爱学习的程序员利用下班时间开发,开发目的是学习Flutter框架',
                    style: TextStyle(fontSize: 18),
                  )),
              Container(
                margin: EdgeInsets.all(10),
                child: Text('相关技术请移步Github', style: TextStyle(fontSize: 18)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.all(5),
                      child: RaisedButton(
                        onPressed: () async {
                          await launch(
                              "https://github.com/HarryLizhujiang/comic_flutter");
                        },
                        child: Text("To GitHub"),
                      )),
                  Container(
                      margin: EdgeInsets.all(5),
                      child: RaisedButton(
                        onPressed: () async {
                          await launch("https://www.lizhujiang.com");
                        },
                        child: Text("JackieLi的博客"),
                      )),
                ],
              ),
              Container(
                child: Text('声明：本项目只做个人学习研究之用，不得用于商业用途！',
                    style: TextStyle(fontSize: 18)),
              ),
              Container(
                child: Text('温馨提示：如果您有什么好的建议可以到我的博客留言，也可以给我发邮箱哦！',
                    style: TextStyle(fontSize: 18)),
              ),
              Container(
                child: Text('作者邮箱：jackieli@lizhujiang.com',
                    style: TextStyle(fontSize: 18)),
              )
            ],
          ),
        ));
  }
}
