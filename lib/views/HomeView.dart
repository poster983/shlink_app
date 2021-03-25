import 'package:flutter/material.dart';

import 'package:shlink_app/widgets/shortener_card.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      /*mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,*/
      children: [new ShortenerCard(), ],
    );
  }
}
