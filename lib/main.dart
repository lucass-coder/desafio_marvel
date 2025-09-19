import 'package:desafio_marvel/app_module.dart';
import 'package:desafio_marvel/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
