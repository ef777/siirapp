import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class view extends StatefulWidget {
  List<String>? gridItems;
  List<String>? gridImage;

  view({
    Key? key,
    required this.gridItems,
    required this.gridImage,
  }) : super(
          key: key,
        );

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {
  ScrollController _controller = new ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => scrollAnimated(500));
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        print("end");
        WidgetsBinding.instance
            .addPostFrameCallback((_) => scrollAnimated(-500));
      }
    });
  }

  void scrollAnimated(double position) {
    _controller.animateTo(
      position,
      duration: Duration(seconds: 70),
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      child: SingleChildScrollView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        child: Container(
            height: 140,
            width: MediaQuery.of(context).size.width * 2.010,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: widget.gridItems!.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return GridTile(
                    child: Container(
                        height: 210,
                        alignment: Alignment.center,
                        child: Stack(children: [
                          Container(
                              height: 70,
                              child: CircleAvatar(
                                radius: 100,
                                backgroundImage: NetworkImage(
                                  widget.gridImage![index],
                                ),
                                backgroundColor: Colors.transparent,
                              )),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                  widget.gridItems![index]))
                        ])));
              },
            )),
      ),
    );
  }
}
