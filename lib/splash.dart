import 'dart:io';
import 'package:page_transition/page_transition.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:siirler/config.dart';
import 'package:siirler/home_page.dart';
import 'package:siirler/welcome/welcome.dart';

import 'home.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _HomeState();
}

class _HomeState extends State<splash> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late bool logindurum = false;

  List pagekey = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  void initState() {
    if (Config.login == 0) {}
    Config.checkInternet();

    super.initState();
  }

// internet check

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      key: _scaffoldKey,
      body: Align(
          alignment: Alignment.center,
          child: AnimatedSplashScreen(
              duration: 1000,
              splash: new Image.asset('lib/assets/images/siir.png'),
              nextScreen: home(),
              splashTransition: SplashTransition.fadeTransition,
              pageTransitionType: PageTransitionType.rightToLeftWithFade,
              backgroundColor: Colors.white)),
    );
  }
}
