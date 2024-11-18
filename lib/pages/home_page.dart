import 'package:flutter/material.dart';
import 'package:habit_tracer/data/database/habit_data_base.dart';
import 'package:habit_tracer/data/model/habit.dart';
import 'package:habit_tracer/habit_utile/is_compeleted.dart';
import 'package:habit_tracer/habit_utile/myhabit_tile.dart';
import 'package:habit_tracer/widgets/add_habit_dialog.dart';
import 'package:habit_tracer/widgets/my_button_theme.dart';
import 'package:habit_tracer/widgets/my_heat_map.dart';
import 'package:habit_tracer/widgets/update_habit.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textHabitController = TextEditingController();
  void createNewHabit() {
    showDialog(
        context: context,
        builder: (context) =>
            AddHabitDialog(textHabitController: textHabitController));
  }

  void checkHabitOnOff(bool? value, Habit habit) {
    if (value != null) {
      context.read<HabitDataBase>().updatedCompletedHAbit(habit.id, value);
    }
  }

  @override
  void dispose() {
    super.dispose();
    textHabitController.dispose();
  }

  void editHabit(Habit habit) {
    textHabitController.text = habit.habitName;
    showDialog(
        context: context,
        builder: (context) => UpdateHabit(
            textHabitController: textHabitController, habit: habit));
  }

  void deleteHabit(int id) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Are you sure you want to delete?"),
              actions: [
                MaterialButton(
                  onPressed: () {
                    context.read<HabitDataBase>().removeHabit(id);
                    Navigator.pop(context);
                  },
                  child: const Text("Delete"),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                )
              ],
            ));
  }

  @override
  void initState() {
    super.initState();
    context.read<HabitDataBase>().readHabit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        actions: const [MyButtonTheme()],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: createNewHabit,
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: [
          buildHabitHeatMap(),
          buildHabits(),
        ],
      ),
    );
  }

  Widget buildHabits() {
    final habitDataBase = context.watch<HabitDataBase>();
    List<Habit> habits = habitDataBase.currentHabit;
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: habits.length,
        itemBuilder: (context, index) {
          final habit = habits[index];
          bool iscompletedtoday = iscompleted(habit.completedDays);
          return MyhabitTile(
            habitName: habit.habitName,
            iscompletedtoday: iscompletedtoday,
            onChanged: (value) => checkHabitOnOff(value, habit),
            editHabit: (p0) => editHabit(habit),
            deleteHabit: (p0) => deleteHabit(habit.id),
          );
        });
  }

  Widget buildHabitHeatMap() {
    final habitDataBase = context.watch<HabitDataBase>();
    List<Habit> habits = habitDataBase.currentHabit;
    return FutureBuilder<DateTime?>(
        future: habitDataBase.getFirstTimeLaunch(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MyHeatMap(
                startDate: snapshot.data!, dataSets: getDataSets(habits));
          } else {
            return Container(child: Text("adfgjh"),);
          }
        });
  }
}
