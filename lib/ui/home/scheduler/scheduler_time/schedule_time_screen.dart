import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:estonedge/base/components/screen_utils/flutter_screenutil.dart';
import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/base/src_constants.dart';
import 'package:estonedge/base/src_widgets.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/utils/widgets/divider_widget.dart';
import 'package:estonedge/ui/home/scheduler/scheduler_home/schedule_home_screen_bloc.dart';
import 'package:estonedge/ui/home/scheduler/scheduler_time/schedule_time_screen_bloc.dart';
import 'package:flutter/material.dart';

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
    Navigator.of(context).pop("scheduleAdded");
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
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ImageView(
              image: AppImages.schedulerIllustration,
              imageType: ImageType.asset),
          SizedBox(height: 10.h),
          DividerWidget(verticalMargin: 5.h),
          SizedBox(height: 20.h),
          Text('The device will be turned on at:', style: fs16BlackRegular),
          StreamBuilder<Time?>(
              stream: getBloc().onTimeStream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return InkWell(
                    onTap: () => showCustomTimePicker(
                        (Time time) => getBloc().setOnTime(time)),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              '${snapshot.data!.hour}hrs ${snapshot.data!.minute}min',
                              style: fs14BlueRegular),
                          const Icon(Icons.lightbulb_outline,
                              color: Colors.blueAccent)
                        ],
                      ),
                    ),
                  );
                } else {
                  return CustomButton(
                      btnText: 'Select Time',
                      color: Colors.blueAccent,
                      onPressed: () => showCustomTimePicker(
                          (Time time) => getBloc().setOnTime(time)));
                }
              }),
          SizedBox(height: 20.h),
          Text('The device will be turned off at:', style: fs16BlackRegular),
          StreamBuilder<Time?>(
              stream: getBloc().offTimeStream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return InkWell(
                    onTap: () => showCustomTimePicker(
                        (Time time) => getBloc().setOnTime(time)),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              '${snapshot.data!.hour}hrs ${snapshot.data!.minute}min',
                              style: fs14BlueRegular),
                          const Icon(Icons.lightbulb, color: Colors.blueAccent)
                        ],
                      ),
                    ),
                  );
                } else {
                  return CustomButton(
                      btnText: 'Select Time',
                      color: Colors.blueAccent,
                      onPressed: () => showCustomTimePicker(
                          (Time time) => getBloc().setOffTime(time)));
                }
              }),
          SizedBox(height: 20.h),
          Text('The device will automatically run on:',
              style: fs16BlackRegular),
          SizedBox(height: 5.h),
          /*buildTimePicker("ON TIME :", _onTime, true),
          const SizedBox(height: 16.0),
          buildTimePicker("OFF TIME :", _offTime, false),
          const SizedBox(height: 40.0),*/
          buildDaysSelector(),
          const Spacer(),
          Center(
            child: Column(
              children: [
                CustomButton(
                  btnText: 'Create',
                  color: Colors.blueAccent,
                  onPressed: _createSchedule,
                ),
                CustomButton(
                  btnText: 'Cancel',
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
        Text(label, style: fs18BlackBold),
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
                Text(time.format(context), style: fs18BlackBold),
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: 15,
        children: List.generate(7, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDays[index] = !selectedDays[index];
              });
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              decoration: BoxDecoration(
                color:
                    selectedDays[index] ? Colors.blueAccent : Colors.grey[100],
                border: Border.all(color: Colors.blueAccent, width: 1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                days[index],
                style: fs14BlackRegular.copyWith(
                  color: selectedDays[index] ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  ScheduleTimeScreenBloc getBloc() => _blocTime;

  void showCustomTimePicker(Function(Time time) onPress) {
    Navigator.of(context).push(
      showPicker(
        accentColor: Colors.blueAccent,
        context: context,
        value: Time.fromTimeOfDay(TimeOfDay.now(), 1),
        sunrise: const TimeOfDay(hour: 6, minute: 0),
        sunset: const TimeOfDay(hour: 18, minute: 0),
        onChange: onPress,
      ),
    );
  }
}
