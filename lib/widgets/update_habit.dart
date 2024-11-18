import 'package:flutter/material.dart';
import 'package:habit_tracer/data/database/habit_data_base.dart';
import 'package:habit_tracer/data/model/habit.dart';
import 'package:provider/provider.dart';

class UpdateHabit extends StatelessWidget {
  const UpdateHabit({super.key,required this.textHabitController,required this.habit});
  final TextEditingController textHabitController;
final Habit habit;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        controller: textHabitController,
        decoration: InputDecoration(
            hintText: "New Habit",
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            )),
      ),
      actions: [
        IconButton(
            onPressed: () {
              context.read<HabitDataBase>().updateHabitName(habit.id, textHabitController.text);
                  textHabitController.clear();
                  Navigator.pop(context);
            },
            icon: const Icon(
              Icons.done,
              color: Colors.green,
            )),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
              textHabitController.clear();
            },
            icon: const Icon(
              Icons.cancel,
              color: Colors.redAccent,
            ))
      ],
    );
  }
}