import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracer/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class MyButtonTheme extends StatelessWidget {
  const MyButtonTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return  IconButton(
                onPressed: () =>
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme(),
                icon: Provider.of<ThemeProvider>(context).isdark
                    ? const Icon(Icons.light_mode)
                    : const Icon(Icons.dark_mode_outlined));
  }
}