import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notewise/core/di/locator.dart';
import 'package:notewise/notewise_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();

  await Hive.initFlutter();
  runApp(const NoteWiseApp());
}
