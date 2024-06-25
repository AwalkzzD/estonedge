import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/base/components/screen_utils/flutter_screenutil.dart';
import 'package:estonedge/base/constants/app_styles.dart';
import 'package:estonedge/base/widgets/custom_page_route.dart';
import 'package:estonedge/ui/home/scheduler/scheduler_time/schedule_time_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/ui/home/scheduler/scheduler_home/schedule_home_screen_bloc.dart';

class ScheduleTimeScreen extends BasePage {
  const ScheduleTimeScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _ScheduleTimeScreenState();

  static Route<dynamic> route() {
    return CustomPageRoute(builder: (context) => const ScheduleTimeScreen());
  }
}

class _ScheduleTimeScreenState
    extends BasePageState<ScheduleTimeScreen, ScheduleTimeScreenBloc> {
  TimeOfDay _onTime = const TimeOfDay(hour: 12, minute: 0);
  TimeOfDay _offTime = const TimeOfDay(hour: 12, minute: 0);
  final ScheduleHomeScreenBloc _bloc = ScheduleHomeScreenBloc();
  final ScheduleTimeScreenBloc _blocTime = ScheduleTimeScreenBloc();

  List<String> days = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];
  List<bool> selectedDays = List.generate(7, (index) => false);

  Future<void> _selectTime(BuildContext context, bool isOnTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isOnTime ? _onTime : _offTime,
    );
    if (picked != null && picked != (isOnTime ? _onTime : _offTime)) {
      setState(() {
        if (isOnTime) {
          _onTime = picked;
        } else {
          _offTime = picked;
        }
      });
    }
  }

  void _createSchedule() async {
    List<String> selectedDaysList = [];
    for (int i = 0; i < days.length; i++) {
      if (selectedDays[i]) {
        selectedDaysList.add(days[i]);
      }
    }

    Map<String, dynamic> schedule = {
      "onTime": _onTime.format(context),
      "offTime": _offTime.format(context),
      "days": selectedDaysList,
    };

    await _bloc.addSchedule(schedule);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  @override
  Widget? getAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: const Text('Scheduler', style: fs24BlackBold),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          buildTimePicker("ON TIME :", _onTime, true),
          const SizedBox(height: 16.0),
          buildTimePicker("OFF TIME :", _offTime, false),
          const SizedBox(height: 40.0),
          buildDaysSelector(),
          const SizedBox(
            height: 50,
          ),
          Spacer(),
          Center(
            child: Column(              
              children: [
                CustomButton(
                  btnText: 'Create',
                  width: 250.0,
                  color: Colors.blueAccent,
                  onPressed: _createSchedule,
                ),
                SizedBox(height: 8.h),
                CustomButton(
                  btnText: 'Cancel',
                  width: 250.0,
                  color: Colors.grey,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTimePicker(String label, TimeOfDay time, bool isOnTime) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () => _selectTime(context, isOnTime),
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              children: [
                Text(
                  time.format(context),
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8.0),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDaysSelector() {
    return Column(
      children: [
        Wrap(
          spacing: 12.0,
          runSpacing: 8.0,
          alignment: WrapAlignment.center,
          children: List.generate(7, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedDays[index] = !selectedDays[index];
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: selectedDays[index]
                      ? Colors.blueAccent
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  days[index],
                  style: TextStyle(
                    color: selectedDays[index] ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  @override
  ScheduleTimeScreenBloc getBloc() => _blocTime;
}
