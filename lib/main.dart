import 'package:demo_api_app/app/app.dart';
import 'package:demo_api_app/services/locator.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await setupDependencies();
  runApp(const MyApp());
}
