import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siirler/detay.dart';

class liste extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('It is Home!'),
                MaterialButton(
                  color: Colors.blue,
                  onPressed: () => Get.toNamed('/second',
                      arguments: {'someArgument': 'someInfo'}),
                  child: Text('Go to second Page'),
                ),
                MaterialButton(
                  color: Colors.blue,
                  onPressed: () => Get.to(detay()),
                  child: Text('Go to third Page'),
                ),
                MaterialButton(
                  color: Colors.blue,
                  onPressed: () => Get.off(() => detay()),
                  child: Text('Go to third Page and Off'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
