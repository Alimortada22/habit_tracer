import 'package:flutter/cupertino.dart';
import 'package:habit_tracer/data/model/app_setting.dart';
import 'package:habit_tracer/data/model/habit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class HabitDataBase extends ChangeNotifier {
  static late Isar isar;
  static  initialization() async {
    final dir = await getApplicationDocumentsDirectory();
    isar =
        await Isar.open([HabitSchema, AppSettingSchema], directory: dir.path);
  }

  static saveDateFirstLaunch() async {
    final appsetting = await isar.appSettings.where().findFirst();
    if (appsetting == null) {
      final setting = AppSetting()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(setting));
    }
  }

  Future<DateTime?> getFirstTimeLaunch() async {
    final setting = await isar.appSettings.where().findFirst();
    return setting?.firstLaunchDate;
  }

  List<Habit> currentHabit = [];
  Future<void> createNewHabit(String newhabit) async {
    final createNewHabit = Habit()..habitName = newhabit;
    await isar.writeTxn(() => isar.habits.put(createNewHabit));
    readHabit();
  }

  Future<void> readHabit() async {
    final fetchedHAbits = await isar.habits.where().findAll();
    currentHabit.clear();
    currentHabit.addAll(fetchedHAbits);
    notifyListeners();
  }

  Future<void> updatedCompletedHAbit(int id, bool iscompleted) async {
    final habit = await isar.habits.get(id);
    if (habit != null) {
      await isar.writeTxn(() async {
        if (iscompleted && !habit.completedDays.contains(DateTime.now())) {
          final today = DateTime.now();
          habit.completedDays.add(DateTime(today.year, today.month, today.day));
        } else {
          habit.completedDays.removeWhere((date) {
            return date.year == DateTime.now().year &&
                date.month == DateTime.now().month &&
                date.day == DateTime.now().day;
          });
        }
        await isar.habits.put(habit);
      });
    }
    readHabit();
  }
Future<void> updateHabitName(int id, String newName)async{
  final habit= await isar.habits.get(id);
  if (habit !=null) {
    await isar.writeTxn(()async{
habit.habitName=newName;
await isar.habits.put(habit);
    });
  }
  readHabit();
}
Future<void> removeHabit(int id)async{
  await isar.writeTxn(()async{
    await isar.habits.delete(id);
  });
  readHabit();
}
}
