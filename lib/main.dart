import 'package:flutter/material.dart';
import 'package:rest_api/src/screen/example_third/examole_three.dart';
import 'package:rest_api/src/screen/example_two/example_two.dart';
import 'package:rest_api/src/screen/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ExamplaThree(),
      //ExamoleTwo(),
      //Home(),
    );
  }
}


