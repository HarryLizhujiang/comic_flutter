import 'package:comic_flutter/pages/HomePage.dart';
import 'package:comic_flutter/router/Navigator_util.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Splash();
  }
}

class _Splash extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    startHome();
  }
  startHome() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (BuildContext context) {
        return HomePage();
      }), (route) => route == null
      );

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/images/logo.png",width: 200.0,height: 200.0,),
                Image.asset("assets/images/logotext.png",width: 400.0,height: 60.0,)
              ],
            ),
          )
      ),
    );
  }
}

