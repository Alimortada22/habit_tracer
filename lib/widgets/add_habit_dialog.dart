import 'package:flutter/material.dart';
import 'package:habit_tracer/data/database/habit_data_base.dart';
import 'package:provider/provider.dart';

class AddHabitDialog extends StatelessWidget {
  const AddHabitDialog({super.key, required this.textHabitController});
  final TextEditingController textHabitController;
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
              context.read<HabitDataBase>().createNewHabit(textHabitController.text);
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
