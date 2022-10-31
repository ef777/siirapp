import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siirler/components/siirdetay.dart';
import 'package:siirler/config.dart';
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
class anasiirtile extends StatefulWidget {
  final String? title;
  final String? resimurl;
  final String? sesurl;
  final String? body;
  final String? kategori;
  final String? yazar;
  final String? tiklandi;

  final String? id;

  const anasiirtile(
      {Key? key,
      required this.tiklandi,
      required this.resimurl,
      required this.sesurl,
      required this.body,
      required this.title,
      required this.kategori,
      required this.yazar,
      required this.id})
      : super(key: key);

  @override
  State<anasiirtile> createState() => _anasiirtileState();
}

class _anasiirtileState extends State<anasiirtile> {
  var c = Get.put(getconfig());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double yukseklik = size.height;
    final double genislik = size.width;
    return GestureDetector(
        onTap: () {
          c.anliksecim = widget.title!;
          c.anlikbaslik = widget.title!;
          c.anlikresim = widget.resimurl!;
          c.anlikyazar = widget.yazar!;
          c.sonurl = widget.sesurl!;
          //  guncelle();
          c.ses();
          c.player.play(c.audioUrl);
          c.isplaying = true;
          c.audioplayed = true;
          c.degistir();
          showModalBottomSheet<void>(
            isScrollControlled: true,
            context: context,
            isDismissible: true,
            builder: (BuildContext context) {
              return FractionallySizedBox(
                  heightFactor: 0.9,
                  child: Container(
                      color: Colors.black,
                      height: 1200,
                      width: 1000,
                      child: siirdetay(
                          resimurl: widget.resimurl,
                          body: widget.body,
                          title: widget.title,
                          yazar: widget.yazar,
                          id: widget.id)));
            },
          );
        },
        child: Container(
          width: genislik * 0.6,
          decoration: BoxDecoration(
            color: widget.tiklandi == widget.title ? Colors.grey : Colors.black,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: CachedNetworkImageProvider(
                  widget.resimurl!,
                ),
              ),
              trailing: const Text(
                "",
                style: TextStyle(color: Colors.green, fontSize: 15),
              ),
              title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "*" + widget.title!,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          ),
                          Text(" Şair: " + widget.yazar!,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 10))
                        ])
                  ])),
        ));
  }
}
