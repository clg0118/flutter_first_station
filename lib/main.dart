import 'package:flutter/material.dart';
import 'package:flutter_first_station/guess/guess_page.dart';
import 'package:flutter_first_station/pager/pager.dart';

import 'counter/counter_page.dart';
import 'muyu/muyu_page.dart';

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
      home: const Pager(),
    );
  }
}


