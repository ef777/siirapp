import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:siirler/error_page.dart';
import 'package:siirler/home.dart';
import 'package:siirler/home_page.dart';

import 'package:siirler/kategoriler.dart';
import 'package:siirler/splash.dart';
import 'package:siirler/welcome/welcome.dart';
import 'dart:io';
import 'package:page_transition/page_transition.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'components/thema.dart';
import 'config.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'pnr',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => splash(),
        '/': (context) => const home(),
        '/welcome': (context) => welcome(),
        '/kategoriler': (context) => kategoriler(),
        '/homepage': (context) => home_page(),
        '/favoriler': (context) => home_page(),
        '/arama': (context) => home_page(),
      },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) => const home(),
            );
          case '/homepage':
            return MaterialPageRoute(
              builder: (context) => home_page(),
            );
          case '/liste':
            return MaterialPageRoute(
              builder: (context) => home_page(),
            );
          case '/arama':
            return MaterialPageRoute(
              builder: (context) => home_page(),
            );
          case '/categories':
            return MaterialPageRoute(
              builder: (context) => home_page(),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => const home(),
            );
        }
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) => const Errorpage());
      },
    );
  }
}
