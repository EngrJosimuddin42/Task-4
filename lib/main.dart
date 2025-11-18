import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/food_provider.dart';
import 'presentation/pages/home_page.dart';

void main() {
  runApp(const Task4App());
}

class Task4App extends StatelessWidget {
  const Task4App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FoodProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Food Classifier',
        theme: ThemeData(primarySwatch: Colors.orange),
        home: const HomePage(),
      ),
    );
  }
}
