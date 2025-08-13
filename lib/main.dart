import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/logging/loggerformain.dart'; // make sure the path is correct
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize logger
  Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);

  // Lock orientation
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Run app
  runApp(const MyApp());
}
