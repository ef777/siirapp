import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siirler/config.dart';
import 'package:siirler/favoriler.dart';
import 'package:siirler/home_page.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';

import 'package:siirler/kategoriler.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _HomeState();
}

class _HomeState extends State<home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late bool logindurum = false;
  var c = Get.put(getconfig());

  List pagekey = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  void initState() {
    c.ses();
    AdHelper.myBanner.dispose();
    AdHelper.myBanner.load();
    super.initState();
  }

  final AdWidget adWidget = AdWidget(ad: AdHelper.myBanner);
// internet check
  pref() async {
    final prefs = await SharedPreferences.getInstance();

    final myStringList = prefs.getStringList('my_string_list_key') ?? [];
    // List jsonList = jsonEncode(c.favori);
    // prefs.setStringList('my_string_list_key', [c.favori]);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> sayfalar = [
      home_page(),
      kategoriler(),
      favoriler(),

      //(Config.logindurum == true) ? const Hesap() : const Login(),
    ];
    return WillPopScope(
        onWillPop: () async {
          var durum =
              await await pagekey[Config.selectedIndex].currentState.maybePop();
          if (durum) {
            return false;
          } else {
            if (Config.selectedIndex == 0) {
              return true;
            } else {
              setState(() {
                Config.selectedIndex = 0;
              });
              return false;
            }
          }
        },
        child: Scaffold(
            backgroundColor: Colors.black,
            key: _scaffoldKey,
            body: Navigator(
              key: pagekey[Config.selectedIndex],
              onGenerateRoute: (routeSettings) {
                return MaterialPageRoute(
                  builder: (context) {
                    return sayfalar[Config.selectedIndex];
                  },
                );
              },
            ),
            bottomNavigationBar: Obx(() => Stack(children: [
                  Text(c.aramadegisti.value.toString()),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      //boxShadow: [boxShadow],
                      borderRadius: BorderRadius.only(
                          // topRight: Radius.circular(20),
                          // topLeft: Radius.circular(20),
                          ),
                    ),
                    child: Column(children: [
                      Container(
                        height: 50,
                        color: Colors.black,
                        child: adWidget,
                      ),
                      Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(0)),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 0),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 5),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: CachedNetworkImageProvider(
                                    c.anlikresim,
                                  ),
                                ),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "-" + c.anlikbaslik,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              FontAwesome.volume_up,
                                              color: Colors.white,
                                              size: 12,
                                            ),
                                            /* Text(c.currentpostlabel,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 10)),*/
                                            Text(" Şair: " + c.anlikyazar,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10))
                                          ]),
                                      /*Container(
                                  height: 10,
                                  margin: const EdgeInsets.only(top: 5),
                                  child: Slider(
                                    activeColor: Colors.white,
                                    value:
                                        double.parse(c.currentpos.toString()),
                                    min: 0,
                                    max: double.parse(c.maxduration.toString()),
                                    divisions: c.maxduration,
                                    label: c.currentpostlabel,
                                    onChanged: (double value) async {
                                      int seekval = value.round();
                                      int result = await c.player.seek(
                                          Duration(milliseconds: seekval));
                                      if (result == 1) {
                                        //seek successful
                                        c.currentpos = seekval;
                                      } else {
                                        print("Seek unsuccessful.");
                                      }
                                    },
                                  )),*/
                                    ]),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        if (!c.isplaying && !c.audioplayed) {
                                          int result =
                                              await c.player.play(c.audioUrl);
                                          if (result == 1) {
                                            //play success
                                            setState(() {
                                              c.isplaying = true;
                                              c.audioplayed = true;
                                            });
                                          } else {
                                            print("Error while playing audio.");
                                          }
                                        } else if (c.audioplayed &&
                                            !c.isplaying) {
                                          int result = await c.player.resume();
                                          if (result == 1) {
                                            //resume success
                                            setState(() {
                                              c.isplaying = true;
                                              c.audioplayed = true;
                                              c.degistir();
                                            });
                                          } else {
                                            print("Error on resume audio.");
                                          }
                                        } else {
                                          int result = await c.player.pause();
                                          if (result == 1) {
                                            //pause success
                                            setState(() {
                                              c.isplaying = false;
                                              c.degistir();
                                            });
                                          } else {
                                            print("Error on pause audio.");
                                          }
                                        }
                                        c.degistir();
                                      },
                                      icon: Icon(
                                          c.isplaying
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          color: Colors.white),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        int result = await c.player.stop();
                                        if (result == 1) {
                                          //stop success
                                          setState(() {
                                            c.isplaying = false;
                                            c.audioplayed = false;
                                            c.currentpos = 0;
                                          });
                                        } else {
                                          print("Error on stop audio.");
                                        }
                                      },
                                      icon: Icon(
                                        Icons.stop,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ])),
                      BottomNavigationBar(
                        selectedIconTheme:
                            const IconThemeData(color: Colors.white),
                        selectedLabelStyle:
                            const TextStyle(color: Colors.white),
                        selectedItemColor: Colors.white,
                        backgroundColor: Colors.black54,
                        type: BottomNavigationBarType.fixed,
                        iconSize: 30,
                        items: const <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                            backgroundColor: Colors.black,
                            icon: Icon(
                              FontAwesome.home,
                              size: 20,
                            ),
                            label: "Ana Sayfa",
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(
                              FontAwesome.list,
                              size: 20,
                            ),
                            label: "Kategoriler",
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(
                              FontAwesome.heart,
                              size: 20,
                            ),
                            label: "Favoriler",
                          ),
                        ],
                        currentIndex: Config.selectedIndex,
                        unselectedItemColor: Colors.grey,
                        onTap: (index) {
                          setState(() {
                            Config.selectedIndex = index;
                            if (index == 0) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => home()));
                            }
                          });
                        },
                      )
                    ]),
                  ),
                ]))));
  }
}

class AdHelper {
  static BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );
}
