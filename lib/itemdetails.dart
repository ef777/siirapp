import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';

// ignore: camel_case_types
class details extends StatefulWidget {
  final String calories,
      category,
      fat,
      minute,
      name,
      p1fiber,
      p2sugars,
      picture_id,
      protein,
      ptcarbs,
      safat,
      servings,
      title,
      who;
  const details(
      {Key? key,
      required this.calories,
      required this.fat,
      required this.category,
      required this.minute,
      required this.name,
      required this.p1fiber,
      required this.p2sugars,
      required this.picture_id,
      required this.protein,
      required this.ptcarbs,
      required this.safat,
      required this.servings,
      required this.title,
      required this.who})
      : super(key: key);

  @override
  State<details> createState() => p_detailsstate();
}

// ignore: camel_case_types
class p_detailsstate extends State<details> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool taze = true, toptan = false, jet = false;

  var total = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 80) / 2.2;
    final double itemWidth = size.width / 2;
    return Scaffold(
        // appbar with image
        key: _scaffoldKey,
        body: Center(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: CustomScrollView(
                  // show pictures from firebase storage
                  slivers: [
                    SliverAppBar(
                      actions: [
                        IconButton(
                            icon: Image.asset(
                              "assets/Iconly-Bold-Paper Download.png",
                              fit: BoxFit.fill,
                              height: 27,
                              width: 27,
                            ),
                            onPressed: () {}),
                        IconButton(
                            icon: Image.asset(
                              height: 20,
                              width: 20,
                              "assets/Fill 936.png",
                              fit: BoxFit.fill,
                            ),
                            onPressed: () {}),
                      ],
                      expandedHeight: 250.0,
                      floating: false,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        background: Image.network(
                          "https://firebasestorage.googleapis.com/v0/b/femispace1-4c30c.appspot.com/o/${widget.picture_id}.png?alt=media&token=6832c199-3727-4971-a247-89071f222224",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                        child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(children: [
                        Text(
                          "${widget.category} * ",
                          style: const TextStyle(
                              color: Colors.yellow,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(widget.who)
                      ]),
                    )),
                    SliverToBoxAdapter(
                        child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
                      child: Text(
                        "${widget.name}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    )),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
                        child: Text(
                          "${widget.title}",
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    "assets/Iconly-Bold-Time Circle.png",
                                    fit: BoxFit.cover,
                                  )),
                              Text("${widget.minute} mins"),
                            ]),
                            const SizedBox(
                              width: 15,
                            ),
                            Row(children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    "assets/Path 7739.png",
                                    fit: BoxFit.cover,
                                  )),
                              Text("${widget.servings} Servings")
                            ]),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                            decoration: new BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: new BorderRadius.circular(
                                  10,
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    child: TextButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      )),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        taze == true
                                            ? Colors.white
                                            : Colors.grey.shade300,
                                      )),
                                  child: Stack(children: [
                                    Text(
                                      "Nutrition",
                                      style: TextStyle(
                                        color: taze == true
                                            ? Colors.black
                                            : Colors.grey,
                                      ),
                                    ),
                                  ]),
                                  onPressed: () {
                                    setState(() {
                                      taze = taze == false ? !taze : true;
                                      toptan = false;
                                      jet = false;
                                      print(taze);
                                      print(toptan);
                                      print(jet);
                                    });
                                  },
                                )),
                                Container(
                                    child: TextButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      )),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        toptan == true
                                            ? Colors.white
                                            : Colors.grey.shade300,
                                      )),
                                  child: Stack(children: [
                                    Text(
                                      "Ingredients",
                                      style: TextStyle(
                                        color: toptan == true
                                            ? Colors.black
                                            : Colors.grey,
                                      ),
                                    ),
                                  ]),
                                  onPressed: () {
                                    setState(() {
                                      taze = false;
                                      toptan = toptan == false ? !toptan : true;
                                      jet = false;
                                    });
                                  },
                                )),
                                Container(
                                    child: TextButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      )),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        jet == true
                                            ? Colors.white
                                            : Colors.grey.shade300,
                                      )),
                                  child: Stack(children: [
                                    Text(
                                      "Directions",
                                      style: TextStyle(
                                        color: jet == true
                                            ? Colors.black
                                            : Colors.grey,
                                      ),
                                    ),
                                  ]),
                                  onPressed: () {
                                    setState(() {
                                      taze = false;
                                      toptan = false;
                                      jet = jet == false ? !jet : true;
                                    });
                                  },
                                )),
                              ],
                            )),
                      ),
                    ),
                    SliverToBoxAdapter(
                        child: taze == true
                            ? Padding(
                                padding: EdgeInsets.all(20),
                                child: Container(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                              child: Column(children: [
                                            Row(children: [
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 1, 0, 1),
                                                  child: Text("Carbs",
                                                      style: TextStyle(
                                                          fontSize: 12))),
                                            ]),
                                            Row(children: [
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Image.asset(
                                                    "assets/wheat.png",
                                                    fit: BoxFit.cover,
                                                  )),
                                              Text("${widget.ptcarbs}g",
                                                  style:
                                                      TextStyle(fontSize: 20))
                                            ]),
                                          ])),
                                          Expanded(
                                              child: Column(children: [
                                            Row(children: [
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 1, 0, 1),
                                                  child: Text("Protein",
                                                      style: TextStyle(
                                                          fontSize: 12)))
                                            ]),
                                            Row(children: [
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Image.asset(
                                                    "assets/Group 15179.png",
                                                    fit: BoxFit.cover,
                                                  )),
                                              Text("${widget.protein}g",
                                                  style:
                                                      TextStyle(fontSize: 20))
                                            ]),
                                          ])),
                                          Expanded(
                                              child: Column(children: [
                                            Row(children: [
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 1, 0, 1),
                                                  child: Text("Fat",
                                                      style: TextStyle(
                                                          fontSize: 12)))
                                            ]),
                                            Row(children: [
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Image.asset(
                                                    "assets/Group 15177.png",
                                                    fit: BoxFit.cover,
                                                  )),
                                              Text("${widget.fat}g",
                                                  style:
                                                      TextStyle(fontSize: 20))
                                            ]),
                                          ])),
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(child: Text("Calories ")),
                                          Text("${widget.calories} kcal")
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        children: [
                                          Expanded(child: Text("Protein ")),
                                          Text("${widget.protein} g")
                                        ],
                                      ),
                                      Divider(),
                                      Row(children: [
                                        Expanded(
                                          child: Text("Carbs"),
                                        ),
                                        Text("${widget.ptcarbs} g")
                                      ]),
                                      Divider(),
                                      Row(children: [
                                        Expanded(
                                          child: Text("Fiber"),
                                        ),
                                        Text("${widget.p1fiber} g"),
                                      ]),
                                      Divider(),
                                      Row(children: [
                                        Expanded(
                                          child: Text("Sugars"),
                                        ),
                                        Text("${widget.p2sugars} g")
                                      ]),
                                      Divider(),
                                      Row(children: [
                                        Expanded(
                                          child: Text("Fat"),
                                        ),
                                        Text("${widget.fat} g"),
                                      ]),
                                      Divider(),
                                      Row(children: [
                                        Expanded(
                                          child: Text("Satured Fat"),
                                        ),
                                        Text("${widget.safat} g"),
                                      ]),
                                    ])))
                            : null),
                    SliverToBoxAdapter(
                        child: toptan == true
                            ? Container(
                                color: Colors.blue,
                              )
                            : null),
                    SliverToBoxAdapter(
                        child: jet == true
                            ? Container(
                                color: Colors.orange,
                              )
                            : null),
                  ],
                ))));
  }
}
