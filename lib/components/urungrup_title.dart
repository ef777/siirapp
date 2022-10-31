import 'package:flutter/material.dart';

// ignore: camel_case_types
class Urungrup_title extends StatelessWidget {
  final String title;
  final String tip;

  final VoidCallback onpress;
  final tiklandi;
  const Urungrup_title(
      {Key? key,
      required this.onpress,
      required this.title,
      this.tiklandi,
      required this.tip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        decoration: BoxDecoration(
          color: tiklandi == tip ? Colors.purple : Colors.black,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Text(title,
            style: TextStyle(
              fontSize: 13,
              color: tiklandi == tip ? Colors.white : Colors.white,
            )),
      ),
    );
  }
}
