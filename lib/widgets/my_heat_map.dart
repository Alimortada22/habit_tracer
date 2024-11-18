import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habit_tracer/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class MyHeatMap extends StatelessWidget {
  const MyHeatMap({super.key,required this.startDate,required this.dataSets});
final DateTime startDate;
final Map<DateTime, int> dataSets;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: HeatMap(
        startDate: startDate,
        endDate: DateTime.now(),
        datasets: dataSets,
        colorMode: ColorMode.color,
        defaultColor: Theme.of(context).colorScheme.secondary,
        showColorTip: false,
        scrollable: true,
        size: 30,
        showText: true,
        textColor:context.read<ThemeProvider>().isdark? Colors.white:Colors.black,
        colorsets: {
        1: Colors.green.shade200,
        2: Colors.green.shade300,
        3: Colors.green.shade400,
        4: Colors.green.shade500,
        5: Colors.green.shade600,
      }),
    );
  }
}
