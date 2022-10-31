import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttericon/font_awesome_icons.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siirler/carosel.dart';
import 'package:siirler/components/anasiirtile.dart';
import 'package:siirler/components/grid.dart';
import 'package:siirler/components/urungrup_title.dart';
import 'package:siirler/config.dart';
import 'package:siirler/kategorisiir.dart';

// ignore: camel_case_types
class kategoriler extends StatefulWidget {
  kategoriler({
    Key? key,
  }) : super(key: key);

  @override
  State<kategoriler> createState() => _kategoriler_pageState();
}

// ignore: camel_case_types
class _kategoriler_pageState extends State<kategoriler> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

  @override
  var c = Get.put(getconfig());
  List songrup = [];
  var son;

  @override
  void initState() {
    // geta(urungruptip);
    //geturungrup(urungruptip);
    super.initState();
  }

  grup(tip) {
    setState(() {
      secimrenk = tip;
      urungruptip = tip;
    });
  }

  Future<dynamic> geturungrup2(String tip) async {
    songrup = await FirebaseFirestore.instance
        .collection("siir")
        .where(tip, isEqualTo: "1")
        .get()
        .then((value) {
      return value.docs.map((e) => e.data()).toList();
    });
    print(songrup.toString());
    print(songrup);
    return songrup;
  }

  Future<dynamic> geturungrup(String tip) async {
    songrup = await FirebaseFirestore.instance
        .collection("kategoriler")
        .get()
        .then((value) {
      return value.docs.map((e) => e.data()).toList();
    });
    print(songrup.toString());
    print(songrup);
    return songrup;
  }

  int urungrupakitf = 0;
  String urungruptip = "soneklenen";
  String secimrenk = "";
  String secili = "";
  @override
  Widget build(BuildContext context) {
    Future<List> resimler;
    Future<List> okunangrup;
    Future<List> onerilengrup;
    Future<List> istenengrup;

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 80) / 2.2;
    final double itemWidth = size.width / 5;
    var veri;
    return Scaffold(
        backgroundColor: Colors.black,
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                ),
                title: const Text('Page 1'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.train,
                ),
                title: const Text('Page 2'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        key: _scaffoldKey,
        body: Obx(() => Stack(children: [
              Text(c.aramadegisti.value.toString()),
              FutureBuilder(
                  future: geturungrup(urungruptip),
                  builder: (BuildContext context, snapshot) {
                    print("future başladı");
                    print(snapshot.data);
                    if (snapshot.hasData) {
                      var veri = songrup;
                      // var banner = snaphost.data![0];
                      return CustomScrollView(slivers: [
                        SliverAppBar(
                          backgroundColor: Colors.black,
                          bottom: AppBar(
                            backgroundColor: Colors.black,
                            elevation: 1,
                            automaticallyImplyLeading: false,
                          ),
                          expandedHeight: 100.0,
                          floating: true,
                          actions: [
                            IconButton(
                              icon: Icon(
                                Icons.info,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                showModalBottomSheet<void>(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return FractionallySizedBox(
                                        heightFactor: 0.4,
                                        child: Container(
                                            color: Colors.black,
                                            height: 300,
                                            child: Center(
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Necmettin Türkekul",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    Text("İnovasyon Ajans 2022",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  ]),
                                            )));
                                  },
                                );
                              },
                            ),
                          ],
                          centerTitle: true,
                          title: SizedBox(
                              width: 100,
                              height: 50,
                              child: Image.asset("lib/assets/images/siir.png")),
                          pinned: true,
                          snap: false,
                        ),
                        SliverToBoxAdapter(
                            child: Container(
                                height: 1000,
                                width: double.infinity,
                                child: ListView.builder(
                                    itemCount: songrup.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet<void>(
                                              isScrollControlled: true,
                                              context: context,
                                              builder: (BuildContext context) {
                                                return FractionallySizedBox(
                                                    heightFactor: 0.9,
                                                    child: Container(
                                                      height: 800,
                                                      color: Colors.black,
                                                      child: Center(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: <Widget>[
                                                            Container(
                                                                height: 300,
                                                                child: katesiir(
                                                                  tip: songrup[
                                                                          index]
                                                                      ["id"],
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                    ));
                                              },
                                            );
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                1, 10, 1, 2),
                                            child: Container(
                                              color: Colors.grey[900],
                                              width: double.infinity,
                                              height: 70,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(songrup[index]
                                                          ["title"])
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ));
                                    }))),
                        /* SliverToBoxAdapter(
                          child: Visibility(
                            visible: (urungruplari.length > 0) ? true : false,
                            child: Container(
                              width: itemWidth,
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              margin: const EdgeInsets.only(top: 0, bottom: 5),
                              height: itemHeight - 40,
                              child: PageView.builder(
                                padEnds: false,
                                controller: _pageController,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                      child: Urun_Blog(
                                    aciklama:
                                        " Klasik çerez lezzetlerinden vazgeçemiyor musunuz? O halde sizlere önerimiz tuzlu fıstık!",
                                    indirim: "var",
                                    title: "Lüks karışık kuruyemiş",
                                    img:
                                        "https://www.cerezpinari.com/UserFiles/Fotograflar/698-kabuklu-badem-cig-410-kabuklu-badem-cig-235-jpg-kabuklu-badem-cig-235-jpg-410-kabuklu-badem-cig-235-jpg-kabuklu-badem-cig-235.jpg",
                                    kargo: "10",
                                    fiyat: "20",
                                    urunkodu: "0",
                                    tip: "100",
                                    birimdeger: "22",
                                    degerlendirme: "4",
                                    yorumadet: "2",
                                    id: "1",
                                  ));
                                },
                                itemCount: urungruplari.length,
                              ),
                            ),
                          ),
                        ),*/
                      ]);
                    } else {
                      return const Center(
                        child: SizedBox(
                          width: 32,
                          height: 32,
                          child: CircularProgressIndicator(
                            color: Colors.purple,
                          ),
                        ),
                      );
                    }
                  })
            ])));
  }
}
