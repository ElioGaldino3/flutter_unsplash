import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_unsplash/app/app_widget.dart';

import 'app/app_setup.dart' as app_setup;

void main() async {
  await dotenv.load(fileName: ".env");
  app_setup.setup();
  runApp(const AppWidget());
}
