import 'package:flutter/material.dart';
import 'package:vsfirst/data/task_inherited.dart';
//import 'package:vsfirst/pages/form_page.dart';
import 'package:vsfirst/pages/initial_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TaskInherited(
          child: const InitialScreen(),
        ));
  }
}
