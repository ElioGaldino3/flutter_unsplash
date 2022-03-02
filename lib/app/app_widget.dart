import 'package:flutter/material.dart';

import 'pages/search_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Unsplash',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: SearchPage(),
    );
  }
}
