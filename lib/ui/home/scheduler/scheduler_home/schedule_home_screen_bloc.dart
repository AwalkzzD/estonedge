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
}
