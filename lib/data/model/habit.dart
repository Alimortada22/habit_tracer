import 'package:isar/isar.dart';
part 'habit.g.dart';
@Collection()
class Habit {
  Id id = Isar.autoIncrement;
  late String habitName;
  List<DateTime> completedDays=[];

}