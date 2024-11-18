import 'package:flutter/material.dart';
import 'package:habit_tracer/data/database/habit_data_base.dart';
import 'package:habit_tracer/pages/home_page.dart';
import 'package:habit_tracer/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HabitDataBase.initialization();
  await HabitDataBase.saveDateFirstLaunch();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => HabitDataBase())
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeDatta,
      home: const HomePage(),
    );
  }
}
