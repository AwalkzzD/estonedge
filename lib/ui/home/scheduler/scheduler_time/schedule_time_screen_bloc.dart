import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:estonedge/base/src_bloc.dart';
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
}
