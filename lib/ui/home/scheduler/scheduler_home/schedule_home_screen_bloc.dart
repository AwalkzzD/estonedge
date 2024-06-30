import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/data/remote/model/schedule/schedule.dart';
import 'package:estonedge/utils/shared_pref.dart';
import 'package:rxdart/rxdart.dart';

class ScheduleHomeScreenBloc extends BasePageBloc {
  late BehaviorSubject<List<Schedule>> schedules;

  get scheduleStream => schedules.stream;

  ScheduleHomeScreenBloc() {
    schedules = BehaviorSubject.seeded([]);
  }

  void loadSchedules() {
    schedules.add(getScheduleList());
  }

  void deleteSchedule(
      Schedule schedule, Function() onSuccess, Function(String) onError) {
    try {
      List<Schedule> scheduleList = List.empty(growable: true);
      scheduleList.addAll(getScheduleList());
      scheduleList.removeAt(scheduleList.indexWhere(
          (scheduleX) => scheduleX.scheduleId == schedule.scheduleId));

      saveScheduleList(scheduleList);

      schedules.add(scheduleList);

      onSuccess();
    } catch (ex) {
      print(ex.toString());
      onError(ex.toString());
    }
  }

/*Future<void> addSchedule(Map<String, dynamic> schedule) async {
    List<Map<String, dynamic>> schedules = await getSchedules();
    schedules.add(schedule);
    await SpUtil.putString(keySchedules, jsonEncode(schedules));
  }

  Future<List<Map<String, dynamic>>> getSchedules() async {
    String? schedulesString = SpUtil.getString(keySchedules);
    if (schedulesString.isNotEmpty) {
      List<dynamic> schedulesJson = jsonDecode(schedulesString);
      return List<Map<String, dynamic>>.from(schedulesJson);
    }
    return [];
  }

  Future<void> deleteSchedule(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final schedulesString = prefs.getString('schedules') ?? '[]';
    final schedules =
        List<Map<String, dynamic>>.from(json.decode(schedulesString));
    schedules.removeAt(index);
    await prefs.setString('schedules', json.encode(schedules));
  }*/
}
