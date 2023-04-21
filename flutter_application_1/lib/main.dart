import 'package:flutter/material.dart';
import 'drawer/menu_drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Flutter Demo'),
        ),
        drawer: MenuDrawer(),
        body: const Center(
          child: Text('Hello, World!'),
        ),
      ),
    );
  }
}
