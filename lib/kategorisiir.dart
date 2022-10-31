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

// ignore: camel_case_types
class katesiir extends StatefulWidget {
  var tip;
  katesiir({
    Key? key,
    required this.tip,
  }) : super(key: key);

  @override
  State<katesiir> createState() => _katesiir_pageState();
}

// ignore: camel_case_types
class _katesiir_pageState extends State<katesiir> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

  @override
  var c = Get.put(getconfig());
  List songrup = [];
  var son;

  @override
  void initState() {
    print(widget.tip);
    print("ssss");
    urungruptip = widget.tip;
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
        .where("kategori", isEqualTo: tip)
        .get()
        .then((value) {
      return value.docs.map((e) => e.data()).toList();
    });
    print(songrup.toString());
    print(songrup);
    return songrup;
  }

  Future<dynamic> geturungrup(String tip) async {
    songrup =
        await FirebaseFirestore.instance.collection("siir").get().then((value) {
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
                  future: geturungrup(widget.tip),
                  builder: (BuildContext context, snapshot) {
                    print("future başladı");
                    print(snapshot.data);
                    if (snapshot.hasData) {
                      var veri = songrup;
                      // var banner = snaphost.data![0];
                      return CustomScrollView(slivers: [
                        SliverToBoxAdapter(
                            child: Container(
                                width: double.infinity,
                                height: 400,
                                child: ListView.builder(
                                    itemCount: songrup.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return anasiirtile(
                                        tiklandi: "1",
                                        yazar: veri[index]["yazar"],
                                        kategori: veri[index]["kategori"],
                                        id: veri[index]["id"],
                                        title: veri[index]["baslik"],
                                        resimurl: veri[index]["resimurl"],
                                        //yazar: songrup[index]["yazar"],
                                        //okunma: songrup[index]["okunma"],
                                        sesurl: veri[index]["sesurl"],
                                        body: veri[index]["body"],
                                      );
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
