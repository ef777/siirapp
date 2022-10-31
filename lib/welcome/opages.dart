import 'package:flutter/material.dart';

final pages = [
  new PageViewModel(
    Color.fromARGB(255, 22, 0, 0),
    'lib/assets/images/siir.png',
    'Şiirler',
    'lorem lorem lorem',
  ),
];

class Pagee extends StatelessWidget {
  final PageViewModel viewModel;
  final double percentVisible;

  Pagee({
    required this.viewModel,
    this.percentVisible = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
        width: double.infinity,
        color: viewModel.color,
        child: new Opacity(
          opacity: percentVisible,
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Transform(
                  transform: new Matrix4.translationValues(
                      0.0, 50.0 * (1.0 - percentVisible), 0.0),
                  child: new Padding(
                    padding: new EdgeInsets.only(bottom: 25.0),
                    child: new Image.asset(viewModel.heroAssetPath,
                        width: 200.0, height: 200.0),
                  ),
                ),
                new Transform(
                  transform: new Matrix4.translationValues(
                      0.0, 30.0 * (1.0 - percentVisible), 0.0),
                  child: new Padding(
                    padding: new EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: new Text(
                      viewModel.title,
                      style: new TextStyle(
                        color: Colors.white,
                        fontFamily: 'FlamanteRoma',
                        fontSize: 34.0,
                      ),
                    ),
                  ),
                ),
                new Transform(
                  transform: new Matrix4.translationValues(
                      0.0, 30.0 * (1.0 - percentVisible), 0.0),
                  child: new Padding(
                    padding: new EdgeInsets.only(bottom: 75.0),
                    child: new Text(
                      viewModel.body,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        color: Colors.white,
                        fontFamily: 'FlamanteRomaItalic',
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ]),
        ));
  }
}

class PageViewModel {
  final Color color;
  final String heroAssetPath;
  final String title;
  final String body;

  PageViewModel(
    this.color,
    this.heroAssetPath,
    this.title,
    this.body,
  );
}
