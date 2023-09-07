import 'package:flutter/material.dart';

import '../modules/myText.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: MyText(text: 'Favorites'),),
    );
  }
}
