import 'package:flutter/material.dart';
import 'package:shopapp/widgets/grocery_list.dart';

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
      theme: ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            surface: const Color.fromARGB(255, 53, 53, 53)),
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        listTileTheme: const ListTileThemeData(
          textColor: Colors.white,
          iconColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const GroceryList(),
    );
  }
}
