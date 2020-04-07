import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_test/pages/homePage.dart';

import 'model/repo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: AppProvider()),
        ],
        child: MaterialApp(
          title: 'Flutter Repos',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomePage(),
        ));
  }
}
