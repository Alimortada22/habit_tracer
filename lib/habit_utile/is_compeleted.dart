import 'package:habit_tracer/data/model/habit.dart';

bool iscompleted(List<DateTime> completedDays) {
  final today = DateTime.now();

  return completedDays.any((date) {
    return today.year == date.year &&
        today.month == date.month &&
        today.day == date.day;
  });
}
Map<DateTime,int> getDataSets(List<Habit> habits){
Map<DateTime,int> datasetes={};
  for (var habit in habits) {
    for (var date in habit.completedDays) {
      final normalizedDate= DateTime(date.year,date.month,date.day);
      if (datasetes.containsKey(normalizedDate)) {
        datasetes[normalizedDate]=datasetes[normalizedDate]!+1;
        
      }else{
        datasetes[normalizedDate]=1;
      }
    }
    
  }
  return datasetes;
}