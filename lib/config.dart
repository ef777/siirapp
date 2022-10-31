import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class getconfig extends GetxController {
  var favori = [];

  favoriyeekle(id) {
    if (favori.contains(id)) {
      favori.remove(id);
      return false;
    } else {
      favori.add(id);
      return true;
    }
  }

  ses() async {
    audioUrl = sonurl;

    Future.delayed(Duration.zero, () async {
      player.setUrl(audioUrl);
      player.onDurationChanged.listen((Duration d) {
        //get the duration of audio
        maxduration = d.inMilliseconds;
        //  );
      });

      player.onAudioPositionChanged.listen((Duration p) {
        currentpos =
            p.inMilliseconds; //get the current position of playing audio

        //generating the duration label
        int shours = Duration(milliseconds: currentpos).inHours;
        int sminutes = Duration(milliseconds: currentpos).inMinutes;
        int sseconds = Duration(milliseconds: currentpos).inSeconds;

        int rhours = shours;
        int rminutes = sminutes - (shours * 60);
        int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

        currentpostlabel = "$rhours:$rminutes:$rseconds";
      });
    });
  }

  int maxduration = 100;
  int currentpos = 0;
  String currentpostlabel = "00:00";
  bool isplaying = false;
  bool audioplayed = false;
  AudioPlayer player = AudioPlayer();
  final player2 = AudioPlayer();
  late String audioUrl;
  String sonurl =
      "https://firebasestorage.googleapis.com/v0/b/siirler-84b54.appspot.com/o/y2mate.com%20-%20%C3%96zdemir%20Asaf%20%20Lavinia.mp3?alt=media&token=5d2e68e5-6c13-45a5-bf33-c59b1bddcf7d";

  // String audioasset =
  //     "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3";

  var anlikresim =
      "https://www.hediyesepeti.com/blog/wp-content/uploads/2017/01/sevgililer-gunu-siirleri-25.jpg";
  var anlikbaslik = "test";
  var anliksure = "a";
  var anlikyazar = "test";
  var anliksesurl = "a";
  var anliksecim = "";

  static final active = false.obs;
  final aramadegisti = false.obs;

  degistir() {
    aramadegisti(!aramadegisti.value);
  }

  test() {
    active(!active.value);
  }
}

class Config extends ChangeNotifier {
  static int login = 0;

  getMethod(String urlm, Object data) async {
    try {
      var sonuc = await http.get(Uri.parse(urlm), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Basic bXVyYXRiYXozNEBnbWFpbC5jb206MTIz'
      });
      if (sonuc.statusCode == 200) {
        return sonuc.body;
      } else {
        return "";
      }
    } catch (error) {
      return "";
    }
  }

  static List sepetliste = [];
  sepetekle(List urunbilgi, adet) {
    for (int i = 0; i < sepetliste.length; i++) {
      if (urunbilgi[0]["urunId"] == sepetliste[i]["urunId"] &&
          urunbilgi[0]["kargo"] == sepetliste[i]["kargo"]) {
        sepetliste[i]["adet"] = sepetliste[i]["adet"] + adet;
        return true;
      }
    }

    if (urunbilgi[0]["adet"] > 0) {
      sepetliste.addAll(urunbilgi);
      return true;
    } else {
      return false;
    }
  }

  static String url = "https:?";
  static final apiKey = "";
  static int selectedIndex = 0;

  static Future<bool> checkInternet() async {
    try {
      print("internet kontrol ediliyor");
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected internet');
        return true;
      }
    } on SocketException catch (_) {
      print('not connected internet');

      return false;
    }
    print("internet kontrol edildi başarısız");
    return false;
  }
}
/*   
                                      */
