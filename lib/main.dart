import 'package:flutter/material.dart';
import 'package:app/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (_) => const HomePage(),
      },
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
