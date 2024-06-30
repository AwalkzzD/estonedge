import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/base/utils/common_utils.dart';
import 'package:estonedge/data/remote/model/schedule/schedule.dart';
import 'package:estonedge/utils/shared_pref.dart';
import 'package:rxdart/rxdart.dart';

class ScheduleTimeScreenBloc extends BasePageBloc {
  late BehaviorSubject<Time?> onTime;
  late BehaviorSubject<Time?> offTime;

  get onTimeStream => onTime.stream;

  get offTimeStream => offTime.stream;

  ScheduleTimeScreenBloc() {
    onTime = BehaviorSubject.seeded(null);
    offTime = BehaviorSubject.seeded(null);
  }

  void setOnTime(Time time) => onTime.add(time);

  void setOffTime(Time time) => offTime.add(time);

  void addSchedule({
    required String scheduleName,
    required String selectedDays,
    required String roomId,
    required String boardId,
    required String switchId,
    required String macAddress,
    required Function() onSuccess,
    required Function(String) onError,
  }) {
    try {
      final schedule = Schedule(
          scheduleId: generateUniqueKey(),
          scheduleName: scheduleName,
          scheduleOnTime: '${onTime.value!.hour}:${onTime.value!.minute}',
          scheduleOffTime: '${offTime.value!.hour}:${offTime.value!.minute}',
          scheduleSelectedDays: selectedDays);

      print('Schedule list --> ${getScheduleList()}');

      List<Schedule> scheduleList = List.empty(growable: true);
      scheduleList.addAll(getScheduleList());
      scheduleList.add(schedule);

      saveScheduleList(scheduleList);

      onSuccess();
    } catch (ex) {
      print(ex.toString());
      onError(ex.toString());
    }
  }
}
