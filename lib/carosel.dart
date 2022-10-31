import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Carousel extends StatefulWidget {
  String option;
  Carousel({
    required this.option,
    Key? key,
  }) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  PageController _pageController = PageController(
    initialPage: 0,
  );

  List<String> images = [
    "https://cdn.odatv4.com/images/2021_03/2021_03_21/dunya-siir-gunu-bilim-aklin-siiridir-siir-de-aklin-bilimidir-21032144_l2.jpg",
    "https://www.hediyesepeti.com/blog/wp-content/uploads/2020/11/ozlem-siirleri.jpg",
    "https://ia.tmgrup.com.tr/2f2834/0/0/0/0/0/0?u=https://i.tmgrup.com.tr/fikriyat/album/2021/12/18/mevlananin-siirinde-peygamber-sevgisi-1639845129175.jpg&mw=752",
  ];

  List<String> secili_images = [];
  int activePage = 1;
  late Timer _timer;
  @override
  void initState() {
    super.initState();

    secili_images = images;
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (activePage < images.length - 1) {
        activePage++;
      } else {
        activePage = 0;
      }

      _pageController.animateToPage(
        activePage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: PageView.builder(
              itemCount: secili_images.length,
              pageSnapping: true,
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  activePage = page;
                });
              },
              itemBuilder: (context, pagePosition) {
                bool active = pagePosition == activePage;
                return slider(secili_images, pagePosition, active);
              }),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                padding: EdgeInsets.fromLTRB(1, 1, 1, 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: indicators(secili_images.length, activePage))))
      ],
    );
  }
}

AnimatedContainer slider(images, pagePosition, active) {
  double margin = active ? 1 : 10;

  return AnimatedContainer(
    duration: Duration(milliseconds: 500),
    curve: Curves.easeInOutCubic,
    margin: EdgeInsets.all(margin),
    decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(images[pagePosition]))),
  );
}

imageAnimation(PageController animation, images, pagePosition) {
  return AnimatedBuilder(
    animation: animation,
    builder: (context, widget) {
      print(pagePosition);

      return SizedBox(
        width: 250,
        height: 200,
        child: widget,
      );
    },
    child: Container(
      margin: EdgeInsets.all(0),
      child: Image.network(images[pagePosition]),
    ),
  );
}

List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: EdgeInsets.all(3),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: currentIndex == index ? Colors.white : Colors.grey,
          shape: BoxShape.circle),
    );
  });
}
