import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class MyhabitTile extends StatelessWidget {
  MyhabitTile(
      {super.key,
      required this.habitName,
      required this.iscompletedtoday,
      required this.onChanged,
      required this.editHabit,
      required this.deleteHabit});
  String habitName;
  bool iscompletedtoday;
  void Function(bool?)? onChanged;
  void Function(BuildContext)? editHabit;
  void Function(BuildContext)? deleteHabit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: editHabit,
            backgroundColor: Colors.grey.shade800,
            icon: Icons.settings,
            borderRadius: BorderRadius.circular(8),
          ),
          SlidableAction(
            onPressed: deleteHabit,
            backgroundColor: Colors.red,
            icon: Icons.delete,
            borderRadius: BorderRadius.circular(8),
          )
        ]),
        child: GestureDetector(
          onTap: () {
            onChanged!(!iscompletedtoday);
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: iscompletedtoday
                    ? Colors.green
                    : Theme.of(context).colorScheme.secondary),
            child: ListTile(
              leading: Checkbox(
                  activeColor: Colors.green,
                  value: iscompletedtoday,
                  onChanged: onChanged),
              title: Text(habitName),
            ),
          ),
        ),
      ),
    );
  }
}
