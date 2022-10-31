import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:siirler/components/Input.dart';
import 'package:siirler/config.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttericon/font_awesome_icons.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siirler/carosel.dart';
import 'package:siirler/components/siirdetay.dart';
import 'package:siirler/components/grid.dart';
import 'package:siirler/components/urungrup_title.dart';
import 'package:siirler/config.dart';

// ignore: camel_case_types
class siirdetay extends StatefulWidget {
  final String? title;
  final String? resimurl;
  final String? body;
  final String? yazar;

  final String? id;

  const siirdetay(
      {Key? key,
      required this.resimurl,
      required this.body,
      required this.title,
      required this.yazar,
      required this.id})
      : super(key: key);

  @override
  State<siirdetay> createState() => _siirdetayState();
}

class _siirdetayState extends State<siirdetay> {
  var c = Get.put(getconfig());
  _shareData() {
    Share.share(
        'Bir şiir paylaşmak istiyorum <a href="https://siirler-84b54.web.app/" target="_blank" rel="noreferrer noopener">https://siirler-84b54.web.app/</a>');
  }

//
  TextEditingController emailController = new TextEditingController();

  yorumekle() async {
    var myData = {
      'kim': "anonim",
      'onay': 1,
      'siirid': widget.id,
      'yorum': emailController.text
    };

    var collection = FirebaseFirestore.instance.collection('yorumlar');
    collection
        .add(myData) // <-- Your data
        .then((_) => print('Added'))
        .catchError((error) => print('Add failed: $error'));
  }

  var songrup;
  Future<dynamic> geturungrup(String tip) async {
    songrup = await FirebaseFirestore.instance
        .collection("yorumlar")
        .where("siirid", isEqualTo: widget.id)
        .get()
        .then((value) {
      return value.docs.map((e) => e.data()).toList();
    });
    print(songrup.toString());
    print(songrup);
    return songrup;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(30),
        height: Get.height,
        width: Get.width,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                  color: Colors.black,
                  height: 500,
                  width: Get.width,
                  child: ListView(
                    children: [
                      Text(widget.title!),
                      Text(
                        widget.body!,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                )),
            Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(
                foregroundColor: Colors.black,
                backgroundColor: Colors.black,
                onPressed: () {
                  _shareData();
                },
                child: Icon(
                  Icons.share,
                  color: Colors.green,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                foregroundColor: Colors.black,
                backgroundColor: Colors.black,
                onPressed: () {},
                child: new InkWell(
                  onTap: () {
                    var deger = c.favoriyeekle(widget.id!);

                    if (deger == true) {
                      Get.snackbar("Favoriler", "Favorilere Eklendi",
                          colorText: Colors.white);
                    } else {
                      Get.snackbar("Favoriler", "Favorilerden Çıkarıldı",
                          colorText: Colors.white);
                    }

                    print(c.favori);
                  },
                  child: new Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                foregroundColor: Colors.black,
                backgroundColor: Colors.black,
                child: Icon(Icons.comment, color: Colors.blue),
                onPressed: () async {
                  await geturungrup("yorumlar");
                  showModalBottomSheet<void>(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return FractionallySizedBox(
                          heightFactor: 0.6,
                          child: Container(
                              height: 800,
                              color: Colors.black,
                              child: Stack(children: [
                                Center(
                                    child: ListView.builder(
                                        itemCount: songrup.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return ListTile(
                                            title: Text(
                                              songrup[index]["yorum"],
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            subtitle: Text(
                                              "Yazan: " + songrup[index]["kim"],
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          );
                                        })),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: FloatingActionButton(
                                    foregroundColor: Colors.black,
                                    backgroundColor: Colors.black,
                                    onPressed: () {
                                      showModalBottomSheet<void>(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return FractionallySizedBox(
                                              heightFactor: 0.6,
                                              child: Container(
                                                  height: 800,
                                                  color: Colors.black,
                                                  child: Stack(children: [
                                                    Center(
                                                      child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal: 8,
                                                                  vertical: 16),
                                                          child: TextField(
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                            cursorColor:
                                                                Colors.white,
                                                            controller:
                                                                emailController,
                                                            obscureText: true,
                                                            textAlign:
                                                                TextAlign.left,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              hintText:
                                                                  'Lütfen Yorumunuzu Yazınız',
                                                              hintStyle: TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          )),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child:
                                                          FloatingActionButton(
                                                        foregroundColor:
                                                            Colors.black,
                                                        backgroundColor:
                                                            Colors.black,
                                                        onPressed: () {},
                                                        child: new InkWell(
                                                          onTap: () async {
                                                            await yorumekle();
                                                            Get.snackbar(
                                                                "Yorum",
                                                                "Başarıyla Gönderildi",
                                                                colorText:
                                                                    Colors
                                                                        .white);
                                                            print("tapped");
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: new Icon(
                                                            Icons.send,
                                                            color:
                                                                Colors.orange,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ])));
                                        },
                                      );
                                    },
                                    child: new InkWell(
                                      child: new Icon(
                                        Icons.message,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                )
                              ])));
                    },
                  );
                },
              ),
            ),
          ],
        ));
  }
}
