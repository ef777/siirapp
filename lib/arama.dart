/* StreamBuilder(
    stream: ( searchtxt!= "" && searchtxt!= null)?FirebaseFirestore.instance.collection("addjop").where("specilization",isNotEqualTo:searchtxt).orderBy("specilization").startAt([searchtxt,])
        .endAt([searchtxt+'\uf8ff',])
        .snapshots()
        :FirebaseFirestore.instance.collection("addjop").snapshots(),
    builder:(BuildContext context,snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting &&
          snapshot.hasData != true) {
        return Center(
            child:CircularProgressIndicator(),
        );
      }
      else
        {retun widget();

*/
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
class arama extends StatefulWidget {
  final String? aranan;

  arama({
    Key? key,
    required this.aranan,
  }) : super(key: key);

  @override
  State<arama> createState() => _aramaState();
}

// ignore: camel_case_types
class _aramaState extends State<arama> {
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
    songrup =
        await FirebaseFirestore.instance.collection("siir").get().then((value) {
      return value.docs.map((e) => e.data()).toList();
    });
    print(songrup.toString());
    print(songrup);
    return songrup;
  }

  String searchtxt = "boş";
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
    searchtxt = widget.aranan.toString();
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
              StreamBuilder(
                  stream: (searchtxt != "" && searchtxt != null)
                      ? FirebaseFirestore.instance
                          .collection("siir")
                          .where("baslik", isNotEqualTo: searchtxt)
                          .orderBy("baslik")
                          .startAt([
                          searchtxt,
                        ]).endAt([
                          searchtxt + '\uf8ff',
                        ]).snapshots()
                      : FirebaseFirestore.instance
                          .collection("siir")
                          .orderBy("baslik")
                          .snapshots(),
                  builder: (BuildContext context, snapshot) {
                    print("data");
                    print(snapshot.data);
                    print(searchtxt);
                    print("bu search");
                    print("aranan");
                    print(widget.aranan);

                    if (snapshot.connectionState == ConnectionState.waiting &&
                        snapshot.hasData != true) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      veri = snapshot.data;

                      if (veri.docs.length == 0) {
                        return Center(
                          child: Text(
                              "Aradığınız kelimeye uygun sonuç bulunamadı"),
                        );
                      }
                      print(veri.docs.length);
                      print("adet");
                      print(veri.docs[0].data()["yazar"]);
                      return CustomScrollView(slivers: [
                        SliverToBoxAdapter(
                            child: Container(
                                width: double.infinity,
                                height: 400,
                                child: ListView.builder(
                                    itemCount: veri.docs.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return anasiirtile(
                                        tiklandi: c.anliksecim,
                                        yazar: veri.docs[index].data()["yazar"],
                                        kategori:
                                            veri.docs[index].data()["kategori"],
                                        id: veri.docs[index].data()["id"],
                                        title:
                                            veri.docs[index].data()["baslik"],
                                        resimurl:
                                            veri.docs[index].data()["resimurl"],
                                        //yazar: songrup[index]["yazar"],
                                        //okunma: songrup[index]["okunma"],
                                        sesurl:
                                            veri.docs[index].data()["sesurl"],
                                        body: veri.docs[index].data()["body"],
                                      );
                                    }))),
                      ]);
                    }
                  }),
            ])));
  }
}
