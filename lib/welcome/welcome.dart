import 'dart:async';

import 'package:flutter/material.dart';
import 'package:siirler/welcome/opages.dart';
import 'package:siirler/welcome/page_dragger.dart';
import 'package:siirler/welcome/page_ind.dart';
import 'package:siirler/welcome/page_rev.dart';

class welcome extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<welcome> with TickerProviderStateMixin {
  late final StreamController<SlideUpdate> slideUpdateStream;
  late final AnimatedPageDragger animatedPageDragger;

  int activeIndex = 0;
  SlideDirection slideDirection = SlideDirection.none;
  int nextPageIndex = 0;
  double slidePercent = 0.0;

  _MyHomePageState() {
    slideUpdateStream = new StreamController<SlideUpdate>();

    slideUpdateStream.stream.listen((SlideUpdate event) {
      setState(() {
        if (event.updateType == UpdateType.dragging) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;

          if (slideDirection == SlideDirection.leftToRight) {
            nextPageIndex = activeIndex - 1;
          } else if (slideDirection == SlideDirection.rightToLeft) {
            nextPageIndex = activeIndex + 1;
          } else {
            nextPageIndex = activeIndex;
          }
        } else if (event.updateType == UpdateType.doneDragging) {
          if (slidePercent > 0.5) {
            animatedPageDragger = new AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.open,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
              slideUpdateThrottleTimeout: Duration(milliseconds: 200),
            );
          } else {
            animatedPageDragger = new AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.close,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
              slideUpdateThrottleTimeout: Duration(milliseconds: 200),
            );
          }

          animatedPageDragger.run();
        } else if (event.updateType == UpdateType.animating) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;
        } else if (event.updateType == UpdateType.doneAnimating) {
          if (animatedPageDragger?.transitionGoal == TransitionGoal.open) {
            activeIndex = nextPageIndex;
          }
          slideDirection = SlideDirection.none;
          slidePercent = 0.0;

          animatedPageDragger.dispose();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: [
          new Pagee(
            viewModel: pages[activeIndex],
            percentVisible: 1.0,
          ),
          new PageReveal(
            revealPercent: slidePercent,
            child: new Pagee(
              viewModel: pages[nextPageIndex],
              percentVisible: slidePercent,
            ),
          ),
          new Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 120),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              '/home',
                            );
                          },
                          child: new Text('Başla'),
                        ),
                      ]))),
        ],
      ),
    );
  }
}
