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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromARGB(255, 224, 255, 216),
            surface: Color.fromARGB(255, 29, 29, 29)),
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: Color(0xFF075E54),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 23),
          iconTheme: IconThemeData(color: Colors.white),
          actionsIconTheme: IconThemeData(color: Colors.white), //
        ),
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
