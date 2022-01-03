import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crud/modules/app_widget.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AppWidget());
}
