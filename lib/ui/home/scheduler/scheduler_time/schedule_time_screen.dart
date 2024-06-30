import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:estonedge/base/components/screen_utils/flutter_screenutil.dart';
import 'package:estonedge/base/constants/app_constants.dart';
import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/base/src_constants.dart';
import 'package:estonedge/base/src_widgets.dart';
import 'package:estonedge/base/utils/common_utils.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/ui/home/scheduler/scheduler_time/schedule_time_screen_bloc.dart';
import 'package:estonedge/ui/profile/profile_details/profile_details_screen.dart';
import 'package:flutter/material.dart';

class ScheduleTimeScreen extends BasePage {
  final String roomId;
  final String boardId;
  final String switchId;
  final String macAddress;

  const ScheduleTimeScreen(
      this.roomId, this.boardId, this.switchId, this.macAddress,
      {super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _ScheduleTimeScreenState();

  static Route<dynamic> route(
          String roomId, String boardId, String switchId, String macAddress) =>
      CustomPageRoute(
          builder: (context) =>
              ScheduleTimeScreen(roomId, boardId, switchId, macAddress));
}

class _ScheduleTimeScreenState
    extends BasePageState<ScheduleTimeScreen, ScheduleTimeScreenBloc> {
  final ScheduleTimeScreenBloc _bloc = ScheduleTimeScreenBloc();

  final TextEditingController scheduleNameController = TextEditingController();
  List<bool> selectedDays = List.generate(7, (index) => false);

  @override
  Widget? getAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: white,
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: Image.asset(AppImages.appBarBackIcon),
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        },
      ),
      title: const Text(
        overflow: TextOverflow.ellipsis,
        'Scheduler',
        style: fs24BlackBold,
      ),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Schedule Name',
                    style: fs16BlackRegular,
                  ),
                  CustomTextField(
                    hintText: 'Schedule Name',
                    controller: scheduleNameController,
                  ),
                  SizedBox(height: 20.h),
                  const Text('The device will be turned on at:',
                      style: fs16BlackRegular),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                  const Text('The device will be turned off at:',
                      style: fs16BlackRegular),
                  StreamBuilder<Time?>(
                      stream: getBloc().offTimeStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return InkWell(
                            onTap: () => showCustomTimePicker(
                                (Time time) => getBloc().setOffTime(time)),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      '${snapshot.data!.hour}hrs ${snapshot.data!.minute}min',
                                      style: fs14BlueRegular),
                                  const Icon(Icons.lightbulb,
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
                                  (Time time) => getBloc().setOffTime(time)));
                        }
                      }),
                  SizedBox(height: 20.h),
                  const Text('The device will automatically run on:',
                      style: fs16BlackRegular),
                  SizedBox(height: 5.h),
                  buildDaysSelector(),
                ],
              ),
            ),
          ),
          CustomButton(
            btnText: 'Create',
            color: Colors.blueAccent,
            onPressed: () {
              getBloc().addSchedule(
                scheduleName: scheduleNameController.text,
                selectedDays: selectedDaysString(selectedDays),
                roomId: widget.roomId,
                boardId: widget.boardId,
                switchId: widget.switchId,
                macAddress: widget.macAddress,
                onSuccess: () {
                  Navigator.pop(context);
                  Navigator.pop(context, "scheduleAdded");
                  showMessageBar('${scheduleNameController.text} created');
                },
                onError: (errorMsg) {
                  showMessageBar(errorMsg);
                },
              );
            },
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
    );
  }

  /*Widget buildTimePicker(String label, TimeOfDay time, bool isOnTime) {
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
  }*/

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
                daysList[index],
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
  ScheduleTimeScreenBloc getBloc() => _bloc;

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
